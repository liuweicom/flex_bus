import 'dart:async';
import 'dart:core';

import 'package:flex_bus/util/javascriptChannel_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewBridge extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
  final bool isNewPage;

  WebViewBridge(
      {Key key,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid,
      this.isNewPage,
      this.url})
      : super(key: key);
  @override
  _WebViewBridgeState createState() => _WebViewBridgeState();
}

class _WebViewBridgeState extends State<WebViewBridge> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if (statusBarColor == "ffffff") {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return widget.isNewPage
        ? _newPageBuild(statusBarColor, backButtonColor)
        : _containerBuild();
  }

  Widget _newPageBuild(String statusBarColor, Color backButtonColor) {
    return WillPopScope(
      child: Scaffold(
//        appBar: AppBar(
//          title: const Text('Flutter WebView example'),
//          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//          actions: <Widget>[
//            NavigationControls(_controller.future),
//            SampleMenu(_controller.future),
//          ],
//        ),
        body: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              _appBar(
                  Color(int.parse("0xff" + statusBarColor)), backButtonColor),
              Expanded(
                child: _webViewItem(context),
              ),
            ],
          );
        }),
      ),
      onWillPop: () {
        if (_webViewController != null) {
          _webViewController.canGoBack().then((res) {
            if (res) {
              _webViewController.goBack();
            } else {
              Navigator.pop(context);
            }
            print(res.toString() + "canGoback==========="); // 是否能返回上一级
          });
        }
      },
    );
  }

  Widget _containerBuild() {
    return Builder(builder: (BuildContext context) => _webViewItem(context));
  }

  //拦截函数
  NavigationDecision _navigationDelegateCallback(NavigationRequest request) {
//    //拦截请求
//    if (request.url.startsWith('https://www.youtube.com/')) {
//      print('拦截请求 $request}');
//      return NavigationDecision.prevent;
//    }
    print('允许请求 $request');
    return NavigationDecision.navigate;
  }

  ///监听实体或者虚拟返回按钮，在第三方也页面中，先返回的是第三方的页面，如果已经返回到了主页，再次点击返回返回到flutter页面
  _onWillPop() {
    if (_webViewController != null) {
      _webViewController.canGoBack().then((res) {
        if (res) {
          _webViewController.goBack();
        } else {
          Navigator.pop(context);
        }
        print(res.toString() + "canGoback==========="); // 是否能返回上一级
      });
    }
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _webViewItem(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted, //js执行模式，是否允许js执行
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
        setState(() {
          _webViewController = webViewController;
        });
      },
      javascriptChannels: JavascriptChannelUtil(
              context: context, controller: _webViewController)
          .getAllChannels()
          .toSet(), //js可以调用flutter
      navigationDelegate: _navigationDelegateCallback,
      onPageFinished: (String url) {
        //页面加载完成回调函数
        print('页面完成加载: $url');
      },
    );
  }
}

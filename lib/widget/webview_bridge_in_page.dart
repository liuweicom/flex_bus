import 'dart:async';
import 'dart:core';

import 'package:flex_bus/util/javascriptChannel_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
class WebViewBridgeInPage extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
  final bool isNewPage;

  WebViewBridgeInPage(
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

class _WebViewBridgeState extends State<WebViewBridgeInPage>{
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  WebViewController _webViewController;

  double progress = 0;
  InAppWebViewController _inAppWebViewController;
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
    return Column(children: <Widget>[
      Container(
          child: progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(height: 6,)
      ),
      Expanded(child:  InAppWebView(
        initialUrl: "https://flutter.io/",
        initialHeaders: {

        },
        initialOptions: {

        },
        onWebViewCreated: (InAppWebViewController controller) {
          _inAppWebViewController = controller;
          //js调用flutter允许有多个参数传入
          _inAppWebViewController.addJavaScriptHandler('handlerFooWithArgs', (args) {
            print(args);
            return [args[0] + 5, !args[1], args[2][0], args[3]['foo']];
          });
          // webView.injectScriptCode("window.appSendJs('hello')");//flutter中调用js

        },
        onLoadStart: (InAppWebViewController controller, String url) {
          //开始加载路径
          print("started $url");
        },
        onLoadStop: (InAppWebViewController controller, String url) async {
          //路径完毕，即将跳转心得路由
          print("stopped $url");
          print("ulr==========加载完毕==============即将跳转");
          setState(() {
            this.progress = 0;
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          print("progress"+progress.toString());
          setState(() {
            this.progress = progress/100;
          });
        },
        shouldOverrideUrlLoading: (InAppWebViewController controller, String url) {
          print("override $url");
          controller.loadUrl(url);
        },
        onLoadResource: (InAppWebViewController controller, WebResourceResponse response, WebResourceRequest request) {
          print("Started at: " +
              response.startTime.toString() +
              "ms ---> duration: " +
              response.duration.toString() +
              "ms " +
              response.url);
        },
        onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
          print("""
              console output:
                sourceURL: ${consoleMessage.sourceURL}
                lineNumber: ${consoleMessage.lineNumber}
                message: ${consoleMessage.message}
                messageLevel: ${consoleMessage.messageLevel}
              """);
        },
      ),
      ),
    ],);
  }


}

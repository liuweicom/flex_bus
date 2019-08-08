import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
  final bool isNewPage;

  WebView({Key key, this.statusBarColor, this.title, this.hideAppBar, this.backForbid, this.url, this.isNewPage=false}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  StreamSubscription<String> _urlStateChange;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewReference.close();
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.startLoad:
//          if(!widget.isNewPage){
//            webviewReference.launch(
//              widget.url,
//              rect: new Rect.fromLTWH(
//                0.0,
//                200,
//                MediaQuery.of(context).size.width,
//                300.0,
//              ),
//            );
//          }
          break;
        default:
          break;
      }
    });
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error){
      print(error.toString()+"网络请求错误");
    });
    _urlStateChange = webviewReference.onUrlChanged.listen((String url){

      print("url:"+url.toString());
    });
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if(statusBarColor == "ffffff"){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }
    return widget.isNewPage?_newPageBuild(statusBarColor, backButtonColor):_containerBuild();
  }

  Scaffold _newPageBuild(String statusBarColor, Color backButtonColor) {
    print("newpage========");
    return Scaffold(
    body: Column(
      children: <Widget>[
        _appBar(Color(int.parse("0xff"+statusBarColor)), backButtonColor),
        Expanded(
          child: WebviewScaffold(
            url: widget.url,
            userAgent: 'xionganapp/1.0.0',//防止携程h5页面重定向到打开携程app ctrip://wireless/xxx的网址服务器能够识别客户使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件
            withZoom: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text("请稍等。。。正在为您加载中"),
              ),
            ),
          ),
        ),
      ],
    ),
  );
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
              onTap: (){
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
                  widget.title?? '',
                  style: TextStyle(color: backButtonColor,fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _containerBuild() {
    return WebviewScaffold(
        url: widget.url,
        userAgent: 'null',//防止携程h5页面重定向到打开携程app ctrip://wireless/xxx的网址
        withZoom: true,
        initialChild: Container(
          color: Colors.white,
          child: Center(
            child: Text("请稍等。。。正在为您加载中"),
          ),
        ),
    );
  }
}

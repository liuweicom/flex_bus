import 'package:flex_bus/util/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class JavascriptChannelUtil{
  final BuildContext context;
  final WebViewController controller;
  List<JavascriptChannel> _channels = [];

  JavascriptChannelUtil({this.context,this.controller});


  JavascriptChannel getLocation(){
    JavascriptChannel result = JavascriptChannel(
        name: 'getLocation',
        onMessageReceived: (JavascriptMessage message) {
          SnackBarUtil.showSnackBar(context, Text(message.message));
          String callback = message.message;
          String data = "你好";
          controller.evaluateJavascript("$callback($data)");
        });
    _channels.add(result);
    return result;
  }

  JavascriptChannel _toasterJavascriptChannel() {
    JavascriptChannel result = JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
          print("收到的消息" + message.message);
        });
    _channels.add(result);
    return result;
  }


  List<JavascriptChannel> getAllChannels(){
    return _channels;
  }
}

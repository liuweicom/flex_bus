import 'package:flex_bus/util/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:amap_base/amap_base.dart';

class JavascriptChannelUtil{
  final _amapLocation = AMapLocation();
  final BuildContext context;
  final WebViewController controller;
  List<JavascriptChannel> _channels = [];

  JavascriptChannelUtil({this.context,this.controller});


  Future<JavascriptChannel> getLocation()async{
    Object data = null;
    final options = LocationClientOptions(
      isOnceLocation: true,
      locatingWithReGeocode: true,
    );
    if (await Permissions().requestPermission()) {
      _amapLocation
          .getLocation(options)
          .then((data){
        data = data;
        print(data.toString()+"onceLocation======");
      })
          .then((_) => print(_.toString()+"定位信息"));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('权限不足')));
    }
    JavascriptChannel result = JavascriptChannel(
        name: 'getLocation',
        onMessageReceived: (JavascriptMessage message) {
          SnackBarUtil.showSnackBar(context, Text(message.message));
          String callback = message.message;
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

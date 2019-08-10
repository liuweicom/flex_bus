import 'package:flex_bus/widget/webview_bridge_in_page.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: WebViewBridgeInPage(
          url: "http://ipts.zpmc.com/ids-admin/#/login",
          hideAppBar: true,
          isNewPage: false,
        )
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//在下一次打开第三方页面的时候可以利用缓存
}

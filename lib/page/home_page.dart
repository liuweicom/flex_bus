import 'package:flex_bus/modal/user_info_model.dart';
import 'package:flex_bus/util/navigator_util.dart';
import 'package:flex_bus/widget/drawer_widget.dart';
import 'package:flex_bus/widget/webview_bridge_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flex_page.dart';
import 'order_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _controller;
  List<String> _tab = ["弹性公交", "预约公交"];
  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: _tab.length, vsync: this);
    super.initState();
  }

  void _handlerDrawerButton(BuildContext context) {
    //控制抽屉打开
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerWidget()),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Column(
            children: <Widget>[
              _appBar(),
              _tabBarItem(),
              _tabBarViewItem(),
              _webViewButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _webViewButton(BuildContext context) {
    return RaisedButton(
      child: Text("弹性公交"),
      onPressed: () {
        NavigatorUtil.push(
          context,
          WebViewBridgeInPage(
            url:
                "https://flutter.dev", //http://ipts.zpmc.com/ids-admin/#/login // "http://ipts.zpmc.com/et-mobile/#/login"
            isNewPage: true,
            title: "背景",
          ),
        );
      },
    );
  }

  Widget _tabBarViewItem() {
    return Flexible(
      child: Container(
//      color: Colors.grey,
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            FlexPage(),
            OrderPage(),
          ],
          physics: ScrollPhysics(),
        ),
      ),
    );
  }

  Widget _tabBarItem() {
    return Container(
      color: Colors.white,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: TabBar(
          controller: _controller,
          isScrollable: false,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
          onTap: (index) {
            print(index.toString() + "index=========");
          },
          tabs: _tab.map((item) => _tabItem(item)).toList(),
        ),
      ),
    );
  }

  _appBar() {
    //这里一定要用Builder的形式去创建组件，应为要调用_handlerDrawerButton需要用到context，及时运用值传递的方式同builder函数传递过来的context是无效的，原因我也不知道
    return Builder(
      builder: (BuildContext context) => Container(
            height: 66,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(7, 25, 7, 0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: _appBarLeftIcon(),
                ),
                Expanded(
                  flex: 1,
                  child: _appBarCenterTitle(),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: _appBarRightIcons(),
                ),
              ],
            ),
          ),
    );
  }

  _appBarRightIcons() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Icon(
            Icons.message,
            size: 20,
            color: Colors.black,
          ),
          onTap: () {
            print("message==========");
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 0,
            right: 0,
            bottom: 0,
          ),
          child: GestureDetector(
            child: Icon(
              Icons.crop_free,
              size: 20,
              color: Colors.black,
            ),
            onTap: () {
              print("scanner=========");
            },
          ),
        ),
      ],
    );
  }

  _appBarCenterTitle() {
    return Center(
      child: GestureDetector(
        onTap: () {
          print("switch-city---------");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("上海市"),
            Icon(
              Icons.expand_more,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  _appBarLeftIcon() {
    return Consumer(
      builder: (context, UserInfoModel userInfo, child) => GestureDetector(
            onTap: () {
              bool isLoginSuccess = userInfo.isLoginSuccess ?? false;
              print("isLoginSuccess:" +
                  isLoginSuccess.toString() +
                  "===================");
              if (isLoginSuccess) {
                _handlerDrawerButton(context);
              } else {
                Navigator.pushNamed(context, "login");
              }
            },
            child: child,
          ),
      child: Icon(
        Icons.person,
        size: 26,
        color: Colors.black,
      ),
    );
  }

  Widget _tabItem(String s) {
    return Tab(
      text: s,
    );
  }
}

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 10,
        child: Text("抽屉！"),
        semanticLabel: "label",
      ),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          decoration: BoxDecoration(color: Colors.grey),
          child: Column(
            children: <Widget>[
              _appBar(),
              Container(
                color: Colors.white,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: TabBar(
                    controller: _controller,
                    isScrollable: false,
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.grey,
                    indicator:
                        UnderlineTabIndicator(borderSide: BorderSide.none),
                    onTap: (index) {
                      print(index.toString() + "index=========");
                    },
                    tabs: _tab.map((item)=>_tabItem(item)).toList(),
                  ),
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[FlexPage(), OrderPage()],
                  physics: ScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      height: 66,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(7, 20, 7, 0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: GestureDetector(
              onTap: () {
                print("print--person----");
              },
              child: Icon(
                Icons.person,
                size: 26,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
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
            ),
          ),
          Container(
            child: Row(
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
                  padding:
                      EdgeInsets.only(left: 20, top: 0, right: 10, bottom: 0),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String s) {
    return Tab(
      text: s,
    );
  }
}

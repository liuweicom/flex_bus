import 'package:flex_bus/modal/ListTileModal.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<ListTileModal> listTileData = [
    ListTileModal(iconsData: Icons.assignment, title: "订单"),
    ListTileModal(iconsData: Icons.verified_user, title: "安全"),
    ListTileModal(iconsData: Icons.account_balance_wallet, title: "钱包"),
    ListTileModal(iconsData: Icons.headset_mic, title: "客服"),
    ListTileModal(iconsData: Icons.settings, title: "设置"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          _drawerHeaderWidget(),
          _listTileWidget(Icons.person, "订单"),
          _listTileWidget(Icons.verified_user, "安全"),
          _listTileWidget(Icons.account_balance_wallet, "钱包"),
          _listTileWidget(Icons.headset_mic, "客服"),
          _listTileWidget(Icons.settings, "设置"),
        ],
      ),
    );
  }

  Widget _drawerHeaderWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(border: Border(bottom: BorderSide.none)),
      child: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              onTap: () {
                print("滴滴页面=======");
              },
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "173*****631",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                print("滴滴页面=======");
              },
            ),
            GestureDetector(
              onTap: () {
                print("普通用户--会员主页");
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.mail,
                          size: 12,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "普通用户",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Icon(Icons.keyboard_arrow_right,
                            size: 12, color: Colors.black54),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTileWidget(iconsData, title) {
    return InkWell(
      onTap: () {
        print("listTileWidget=====" + title);
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              padding: EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              child: Icon(
                iconsData,
                color: Colors.black54,
                size: 16,
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(right: 15),
//              child:
//            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _listTiles() {
    return listTileData
        .map(
            (ListTileModal item) => _listTileWidget(item.iconsData, item.title))
        .toList();
  }
}

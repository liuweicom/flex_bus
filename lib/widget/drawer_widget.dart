import 'package:flex_bus/modal/ListTileModal.dart';
import 'package:flex_bus/modal/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {
    //获取顶层数据最简单的方法，这里的泛型指定了获取该页面向上寻找最近存储了T的祖先节点的数据，如果使用这种方式更新，会导致频繁刷新context,导致页面刷新build函数
    final userInfo = Provider.of<UserInfoModel>(context);//获取顶层数据最简单的方法就是 Provider.of<T>(context)
    String telephone = userInfo.isLoginSuccess?? false ?((userInfo.telephone?.length ?? 0) >10 ? userInfo.telephone.replaceRange(3, 8, "*****") : "") :"";
    print(userInfo.telephone.toString()+"print==========");
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          _drawerHeaderWidget(telephone),
          _listTileWidget(Icons.person, "订单",()=>print("订单========"), null),
          _listTileWidget(Icons.verified_user, "安全",()=>print("安全========"), null),
          _listTileWidget(Icons.account_balance_wallet, "钱包",()=>print("钱包========"), null),
          _listTileWidget(Icons.headset_mic, "客服",()=>print("客服========"), null),
          _listTileWidget(Icons.settings, "设置",()=>print("订单========"), null),
          _listTileWidget(Icons.settings, "退出",(userInfo){
            userInfo.setInfo("","","");
          }, userInfo),
        ],
      ),
    );
  }

  Widget _drawerHeaderWidget(String telephone) {
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
                  telephone,
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
                  ),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTileWidget(iconsData, title, callBack, userInfo) {
    return InkWell(
      onTap: () {
        callBack(userInfo);
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

}

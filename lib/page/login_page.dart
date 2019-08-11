import 'package:flex_bus/modal/user_info_model.dart';
import 'package:flex_bus/page/password_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = TextEditingController();

  bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _firstTitle(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: _secondSamllTitle(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: _TextFiledItem(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: _TextFiledSubTitle(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: _submitItem(),
            ),
          ],
        ),
        ),
      ),
    );
  }

  FractionallySizedBox _submitItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Consumer<UserInfoModel>(
        builder: (context, UserInfoModel userInfo, child) => RaisedButton(
              child: child,
              textColor: Colors.white,
              color: Colors.blueAccent,
              onPressed: _raisedButtonPressed(userInfo),
            ),
        child: Text("下一步"),
      ),
    );
  }

  GestureDetector _TextFiledSubTitle() {
    return GestureDetector(
      onTap: () {
        print("手机号已经不在使用");
      },
      child: Row(
        children: <Widget>[
          Text(
            "手机号已经不在使用",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: 16,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  TextField _TextFiledItem() {
    return TextField(
      keyboardType: TextInputType.phone,
      controller: _controller,
      autofocus: true,
      cursorColor: Colors.grey,
      style: TextStyle(fontSize: 20, decoration: TextDecoration.none),
      decoration: _decorationStyle(),
      onChanged: (str) {
        if (str.length == 0) {
          setState(() {
            isEnable = false;
          });
        } else {
          setState(() {
            isEnable = true;
          });
        }
      },
    );
  }

  Text _secondSamllTitle() {
    return Text(
      "为了方便进行联系，请输入您的常用手机号码",
      style: TextStyle(
        fontSize: 12,
      ),
    );
  }

  Text _firstTitle() {
    return Text(
      "请输入手机号码",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        child: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.black54,
          size: 30,
        ),
        onTap: () {
          print("return back=====");
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  _decorationStyle() {
    return InputDecoration(
      icon: _iconItem(),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      hintText: "请输入电话号码",
      hintStyle: TextStyle(color: Colors.black54),
    );
  }

  _iconItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
      ),
      width: 55,
      height: 35,
      child: GestureDetector(
        onTap: () {
          print("+86=======");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "+86",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  _raisedButtonPressed(UserInfoModel userInfo) {
    if (!isEnable) {
      return null;
    } else {
      return () {
        print(_controller.text.toString() + "onPresede===========");
        userInfo.setTelephone(_controller.text.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PassWordPage()));
//        Navigator.pushNamed(context, "password",
//            arguments: {"telephone": _controller.text});//通过路由传递数据的方式，context一直都在不断的刷新，效率不太高
      };
    }
  }
}

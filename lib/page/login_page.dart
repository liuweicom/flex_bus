import 'package:flutter/material.dart';

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
      appBar: AppBar(
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
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "请输入手机号码",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "为了方便进行联系，请输入您的常用手机号码",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: TextField(
                controller: _controller,
                autofocus: true,
                cursorColor: Colors.grey,
                style: TextStyle(fontSize: 20, decoration: TextDecoration.none),
                decoration: _decorationStyle(),
                onChanged: (str) {
                  if(str.length == 0){
                    setState(() {
                      isEnable = false;
                    });
                  }else{
                    setState(() {
                      isEnable = true;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
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
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: RaisedButton(
                  child: Text("下一步"),
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                  onPressed: _rasedButtonPress(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _decorationStyle() {
    return InputDecoration(
      icon: _iconItem(),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
        onTap: (){
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
      ),),
    );
  }

  _rasedButtonPress() {
    if (!isEnable) {
      return null;
    } else {
      return () {
        print(_controller.text.toString() + "onPresede===========");
      };
    }
  }
}

import 'package:flutter/material.dart';
class PassWordPage extends StatefulWidget {
  final arguments;
  PassWordPage({key : Key, this.arguments});
  @override
  _PassWordPageState createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {

  bool isEnable = false;

  bool isEye = false;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context).settings.arguments;//获取通过路由传过来的参数，这里是电话号码
    print(obj.toString()+"params==========");
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "6-16位密码",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  TextField(
                    obscureText: !isEye,//是否隐藏输入
                    autofocus: true,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                        suffix: GestureDetector(
                          onTap: (){
                            print("sufix");
                            setState(() {
                              isEye = !isEye;
                            });
                          },
                          child: Icon(isEye ? Icons.visibility : Icons.visibility_off),
                        )
                    ),
                    style: TextStyle(fontSize: 20, decoration: TextDecoration.none),
                    onChanged: (str){
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
                ],
              ),),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
                  print("忘记密码");
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      "忘记密码",
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
                  child: Text("确认"),
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                  onPressed: _raisedButtonPressed(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _raisedButtonPressed() {
    if (!isEnable) {
      return null;
    } else {
      return () {
        print(_controller.text.toString() + "onPresede===========");
      };
    }
  }
}

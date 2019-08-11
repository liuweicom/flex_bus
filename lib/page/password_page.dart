import 'package:flex_bus/modal/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

//  Map<String,dynamic> routeArgument;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //方式一： Provider.of<T>(context)，这里的泛型指定了获取该页面向上寻找最近存储了T的祖先节点的数据，如果使用这种方式更新，会导致频繁刷新context,导致页面刷新build函数
    //方法二：使用Consumer获取组件节点中的数据。
    //Consumer使用了Builder模式，收到更新通知就会通过builder重新构建，Consumer<T>代表了他要获得哪一个祖先中的Model
    //builder:(BuilderContext context,T model,Widget child){} //child它用来构建那些与Model无关的部分，在多次builder中，child不会重新构建

    //    routeArgument = ModalRoute.of(context).settings.arguments;//获取通过路由传过来的参数，这里是电话号码

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
        child: SingleChildScrollView(child: Column(
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
                child: Consumer(
                  builder: (context, UserInfoModel userInfo, child)=>RaisedButton(
                    child: child,
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: _raisedButtonPressed(userInfo),
                  ),
                  child: Text("确认"),
                ),
              ),
            ),
          ],
        ),
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
        userInfo.setPassWord(_controller.text.toString());
        userInfo.setRoles("admin");
        userInfo.setIsLoginSuccess(true);
        Navigator.pop(context);
        Navigator.pop(context);
//        Navigator.pushNamed(context, "homePage");//没有按返回键，会回退到输入密码页，不是整整回退到首页
      };
    }
  }
}

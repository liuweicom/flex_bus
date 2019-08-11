import 'package:flutter/material.dart';

class UserInfoModel with ChangeNotifier {
  String _passWord;
  String _roles;
  String _telephone;
  bool _isLoginSuccess;

  String get passWord => _passWord;
  String get roles=> _roles;
  String get telephone=> _telephone;
  bool get isLoginSuccess=> _isLoginSuccess;

  void setInfo(String telephone,String passWord,String roles,bool isLoginSuccess){
    this._telephone = telephone;
    this._passWord = passWord;
    this._roles = roles;
    this._isLoginSuccess = isLoginSuccess;
    notifyListeners();//ChangeNotifier，这个类能够帮助我们自动管理所有听众，当调用notifyListeners时，它会通知所有听众进行刷新
  }

  void setTelephone(String telephone){
    this._telephone = telephone;
    notifyListeners();//ChangeNotifier，这个类能够帮助我们自动管理所有听众，当调用notifyListeners时，它会通知所有听众进行刷新
  }

  void setPassWord(String passWord){
    this._passWord = passWord;
    notifyListeners();//ChangeNotifier，这个类能够帮助我们自动管理所有听众，当调用notifyListeners时，它会通知所有听众进行刷新
  }

  void setIsLoginSuccess(bool isLoginSuccess){
    this._isLoginSuccess = isLoginSuccess;
    notifyListeners();//ChangeNotifier，这个类能够帮助我们自动管理所有听众，当调用notifyListeners时，它会通知所有听众进行刷新
  }

  void setRoles(String roles){
    this._roles = roles;
    notifyListeners();//ChangeNotifier，这个类能够帮助我们自动管理所有听众，当调用notifyListeners时，它会通知所有听众进行刷新
  }


}
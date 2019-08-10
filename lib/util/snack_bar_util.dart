import 'package:flutter/material.dart';
class SnackBarUtil{
  static showSnackBar(BuildContext context, Widget child){
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: child
      ),
    );
  }
}
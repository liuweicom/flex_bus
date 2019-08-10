import 'package:flutter/material.dart';

class FlexPage extends StatefulWidget {
  @override
  _FlexPageState createState() => _FlexPageState();
}

class _FlexPageState extends State<FlexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Text("弹性公交=========="),
      ),
    );
  }
}

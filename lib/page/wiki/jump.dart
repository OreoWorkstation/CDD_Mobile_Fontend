import 'package:flutter/material.dart';

class JumpPage extends StatefulWidget {
  JumpPage({Key key}) : super(key: key);

  @override
  _JumpPageState createState() => _JumpPageState();
}

class _JumpPageState extends State<JumpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JUMP"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'user_page.dart';
void main() {
  runApp(Aboutus());
}

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "关于我们",
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: new AppBar(
          title: new Text(
            '关于我们',
            style: new TextStyle(color: Colors.deepPurpleAccent),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Text('nothing'),
        ),
      ),
    );
  }
}

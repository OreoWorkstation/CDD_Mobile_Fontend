import 'package:flutter/material.dart';
import 'user_page.dart';
void main() {
  runApp(Help());
}

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "帮助",
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: new AppBar(
          title: new Text(
            '帮助',
            style: new TextStyle(color: Colors.deepPurpleAccent),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey,Colors.white],
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

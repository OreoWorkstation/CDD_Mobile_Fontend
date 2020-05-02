import 'package:flutter/material.dart';

class DiaryAddPage extends StatefulWidget {
  DiaryAddPage({Key key}) : super(key: key);

  @override
  _DiaryAddPageState createState() => _DiaryAddPageState();
}

class _DiaryAddPageState extends State<DiaryAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Diary Add"),
      ),
    );
  }
}

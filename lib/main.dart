import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/page/index/index.dart';
import 'package:flutter/material.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cat Dog Diary",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: IndexPage(),
    );
  }
}

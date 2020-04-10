import 'dart:io';

import 'package:cdd_mobile_frontend/view/init_page.dart';
import 'package:cdd_mobile_frontend/view/page/pet/add_pet_page.dart';
import 'package:cdd_mobile_frontend/view/page/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cat Dog Diary",
      routes:{
        "homepage":         (context) => CddInitPage(),
        "add_pet_page":     (context) => AddPetPage(),
      },
      initialRoute: "homepage",
    );
  }
}

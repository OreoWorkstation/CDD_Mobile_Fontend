import 'package:cdd_mobile_frontend/common/provider/provider_manager.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/page/application/application.dart';
import 'package:cdd_mobile_frontend/page/index/index.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: "Cat Dog Diary",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          routes: {
            "/application": (context) => ApplicationPage(),
          },
          home: IndexPage(),
        ),
      ),
    );
  }
}

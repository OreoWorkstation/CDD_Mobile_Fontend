import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/page/sign_in/sign_in.dart';
import 'package:cdd_mobile_frontend/page/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    ScreenUtil.init(
      context,
      width: 375,
      height: 812 - 44 - 34,
      allowFontScaling: true,
    );

    return Global.isFirstOpen == true ? WelcomePage() : SignInPage();
    // return Scaffold(
    //   body: Global.isFirstOpen == true ? WelcomePage() : SignInPage(),
    // );
  }
}

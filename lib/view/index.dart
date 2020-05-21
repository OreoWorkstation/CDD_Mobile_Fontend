import 'dart:async';

import 'package:cdd_mobile_frontend/common/router/fluro_navigator.dart';
import 'package:cdd_mobile_frontend/common/router/user_router.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/widget/image.dart';
import 'package:cdd_mobile_frontend/demo/demo.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/view/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _status = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSplash();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      // TODO: Change it if it is release
//      if (Global.isFirstOpen) {
//        _initGuide();
//      } else {
//        _goLogin();
//      }
      _initGuide();
    });
  }

  void _goLogin() {
    NavigatorUtil.push(context, UserRouter.LOGIN, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    ScreenUtil.init(
      context,
      width: 375,
      height: 812 - 44 - 34,
      allowFontScaling: true,
    );

    return Material(
      child: _status == 0
          ? FractionallyAlignedSizedBox(
              heightFactor: 0.3,
              widthFactor: 0.33,
              leftFactor: 0.33,
              bottomFactor: 0,
              child: const LoadAssetImage("logo"),
            )
          : SplashPage(),
    );

    //return SplashPage();
    //return DemoPage();
//    return Global.isFirstOpen == true ? SplashPage() : SignInPage();
  }
}

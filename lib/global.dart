import 'dart:io';

import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/common/router/application.dart';
import 'package:cdd_mobile_frontend/common/router/routers.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

class Global {
  /// 用户Token
  static String accessToken = "";

  /// APP是否第一次打开
  static bool isFirstOpen = false;

  /// init
  static Future init() async {
    // 运行初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始化
    await StorageUtil.init();
    HttpUtil();

    // 初始化语言：日历显示中文
    initializeDateFormatting();

    // 初始化Fluro
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;


    // APP是否第一次打开
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // 持久化用户Token
  static Future<bool> saveToken(String token) {
    accessToken = token;
    return StorageUtil().setString(STORAGE_ACCESS_TOKEN, token);
  }
}

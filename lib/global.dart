import 'dart:io';

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/value/value.dart';

class Global {
  /// APP是否第一次打开
  static bool isFirstOpen = false;

  /// init
  static Future init() async {
    // 运行初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始化
    await StorageUtil.init();

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
}

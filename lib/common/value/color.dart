import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  /// 主背景 白色
  static const Color primaryBackground = Color.fromARGB(255, 255, 255, 255);

  /// 主文本 灰色
  static const Color primaryText = Color.fromARGB(255, 45, 45, 47);

  /// 主控件-背景 蓝色
  static const Color primaryElement = Color.fromARGB(255, 0, 122, 255);

  /// 主控件-文本 白色
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);

  // *****************************

  /// 第二种控件-背景色 灰色
  static const Color secondaryElement = Color.fromARGB(255, 174, 174, 178);

  /// 第三种控件-背景色 浅灰色
  static const Color thirdElement = Color.fromARGB(255, 246, 246, 246);

  // ****************************

  /// 底部导航栏控件颜色-未选中
  static const Color tabElementInactive = Color.fromARGB(255, 0, 0, 0);

  /// 底部导航栏控件颜色-选中
  static const Color tabElementActive = Color.fromARGB(255, 28, 189, 151);

  // ****************************

  /// 宠物列表卡片背景色
  static const List<LinearGradient> petCardColors = [
    LinearGradient(
      colors: [
        Color.fromARGB(255, 236, 111, 102),
        Color.fromARGB(255, 243, 161, 131),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromARGB(255, 142, 45, 226),
        Color.fromARGB(255, 74, 0, 224),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromARGB(255, 75, 108, 183),
        Color.fromARGB(255, 24, 40, 72),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];
}

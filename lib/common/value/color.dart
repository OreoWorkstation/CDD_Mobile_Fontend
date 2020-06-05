import 'package:flutter/material.dart';

class AppColor {
  static const Color background = Color(0xFFF7F6FC);
  static const Color primary = Color(0xFF2972FF);
  static const Color dark = Color(0xFF222222);
  static const Color grey = Color(0xFF707E89);
  static const Color lightGrey = Color(0xFFAEBBC2);
  static const Color extraLightGrey = Color(0xE1E8ED);
  // static const Color testBlueColor1 = Color(0xFF2972FF);
  // using
  static const Color testBlueColor1 = Color(0xFF2972FF);
  static const Color testBlueColor2 = Color(0xFF5f67ec);
  static const Color testBlueColor3 = Color(0xFF5f67ec);

  static const Color testBgColor1 = Color(0xFFE5EAF6);
  static const Color testBgColor2 = Color(0xFFF2F5FE);
  static const Color testBgColor3 = Color(0xFFF7F6FC);
  static const Color testBgColor4 = Color(0xFFE9E9E9);

  static const Color testTextBlackColor1 = Color(0xff4B6163);
  // static const Color testTextBlackColor2 = Color(0xff403f40);
  // using
  static const Color testTextBlackColor2 = Color(0xff222222);
  // static const Color testTextBlackColor2 = Color(0xff302A50);
  static const Color testTextWhiteColor1 = Color(0xffdee9ff);

  static const Color testGreyColor1 = Color(0xffbabdcb);

  /// 主文本 灰色
  static const Color primaryText = Color.fromARGB(255, 45, 45, 47);

  /// 主控件-背景 蓝色
  static const Color primaryElement = Color.fromARGB(255, 0, 122, 255);

  /// 主控件-文本 白色
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);

  /// 主控件-按钮背景 红色
  static const Color primaryElementRed = Color.fromARGB(255, 255, 45, 85);

  // *****************************

  /// 第二种控件-背景色 灰色
  static const Color secondaryElement = Color.fromARGB(255, 174, 174, 178);

  /// 第三种控件-背景色 浅灰色
  static const Color thirdElement = Color.fromARGB(255, 246, 246, 246);

  /// 第二种文本颜色 浅灰色
  static const Color secondaryTextColor = Color.fromARGB(255, 60, 60, 67);

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
        // Color.fromARGB(255, 243, 161, 131),
        Color.fromARGB(235, 236, 111, 102),
        Color.fromARGB(230, 236, 111, 102),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color.fromARGB(200, 74, 0, 224),
        Color.fromARGB(220, 74, 0, 224),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];

  // ****************************

  /// 宠物体重背景色
  static const Color weightColor = Color.fromARGB(255, 68, 217, 168);

  /// 宠物日记背景色
  static const Color diaryColor = Color.fromARGB(255, 63, 100, 245);

  /// 宠物消费背景色
  static const Color costColor = Color.fromARGB(255, 197, 109, 241);

  /// 宠物相片背景色
  static const Color photoColor = Color.fromARGB(255, 250, 59, 148);

  // ****************************

  /// 体重和账单列表项颜色
  static const List listItemColors = [
    Color.fromARGB(255, 50, 245, 141),
    Color.fromARGB(255, 255, 175, 137),
    Color.fromARGB(255, 147, 118, 246),
    Color.fromARGB(255, 240, 92, 106),
    Color.fromARGB(255, 235, 240, 105),
  ];
}

/*
class AppColor {
  static final Color primary = Color(0xff1DA1F2);
  static final Color secondary = Color(0xff14171A);
  static final Color darkGrey = Color(0xff657786);
  static final Color lightGrey = Color(0xffAAB8C2);
  static final Color extraLightGrey = Color(0xffE1E8ED);
  static final Color extraExtraLightGrey = Color(0xfF5F8FA);
  static final Color white = Color(0xFFffffff);
}
*/

class Colours {
  static const Color app_main = Color(0xFF4688FA);
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);
}

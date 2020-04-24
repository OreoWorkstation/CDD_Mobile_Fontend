import 'package:flutter/material.dart';

/// 默认白底黑字
Widget appBarWidget({
  Color bgColor = Colors.white,
  Brightness brightness = Brightness.light,
  Widget title,
  Widget leading,
  List<Widget> actions,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(0),
    child: AppBar(
      backgroundColor: bgColor,
      brightness: brightness,
      elevation: 0.0,
      title: title,
      centerTitle: true,
      leading: leading,
      actions: actions,
    ),
  );
}

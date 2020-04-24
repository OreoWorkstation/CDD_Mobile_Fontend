import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

Widget inputTextEditWidget({
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String hintText,
  bool isPassword = false,
  double marginTop = 24,
  bool autofocus = false,
  double height = 48.0,
}) {
  return Container(
    height: cddSetHeight(height),
    margin: EdgeInsets.only(top: cddSetHeight(marginTop)),
    decoration: BoxDecoration(
      color: AppColor.thirdElement,
      borderRadius: Radii.k10pxRadius,
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: cddSetFontSize(18.0),
      ),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
    ),
  );
}

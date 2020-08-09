import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

Widget primaryBtn({
  @required VoidCallback onPressed,
  double height = 45.0,
  double width = 250.0,
  Color bgColor = AppColor.primary,
  @required String title,
  double fontSize = 20.0,
  BorderRadiusGeometry radii = Radii.k24pxRadius,
}) {
  return Container(
    height: sHeight(height),
    width: sWidth(width),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: radii,
    ),
    child: FlatButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: sSp(fontSize),
        ),
      ),
    ),
  );
}

/// 纯文本button
Widget textBtnFlatButtonWidget({
  @required VoidCallback onPressed,
  @required String title,
  Color textColor = AppColor.primary,
  double fontSize = 16,
}) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: sSp(fontSize),
        color: textColor,
      ),
    ),
  );
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color btnColor;
  final Color textColor;
  final String content;
  final double fontSize;
  final BorderRadiusGeometry radius;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.height,
    this.width,
    this.btnColor,
    this.textColor,
    this.content,
    this.fontSize,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

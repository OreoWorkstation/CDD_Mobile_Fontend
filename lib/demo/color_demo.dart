import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

/*
static final Color primary = Color(0xff1DA1F2);
  static final Color secondary = Color(0xff14171A);
  static final Color darkGrey = Color(0xff1657786);
  static final Color lightGrey = Color(0xffAAB8C2);
  static final Color extraLightGrey = Color(0xffE1E8ED);
  static final Color extraExtraLightGrey = Color(0xfF5F8FA);
  static final Color white = Color(0xFFffffff);
 */
List<Color> colorList = [
  AppColor.primary,
  AppColor.secondary,
  AppColor.darkGrey,
  AppColor.lightGrey,
  AppColor.extraLightGrey,
  AppColor.extraExtraLightGrey,
  AppColor.white,
];

class ColorDemoPage extends StatefulWidget {
  @override
  _ColorDemoPageState createState() => _ColorDemoPageState();
}

class _ColorDemoPageState extends State<ColorDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Demo"),
      ),
      body: _buildColorList(),
    );
  }

  Widget _buildColorList() {
    return ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          "Color List",
          style: TextStyle(
            color: colorList[index],
          ),
        ),
      );
    },
    itemCount: colorList.length,);
  }
}

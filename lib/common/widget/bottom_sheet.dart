import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

/// 底部弹出框: 编辑，删除，取消
Widget commonBottomSheetWidget({
  @required BuildContext context,
  VoidCallback editOnTap,
  VoidCallback deleteOnTap,
}) {
  return Container(
    height: cddSetHeight(250),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "选择要执行的操作",
            style: TextStyle(
              fontSize: cddSetFontSize(17),
              color: AppColor.secondaryTextColor.withOpacity(0.7),
            ),
          ),
          ListTile(
            title: Text(
              "编辑",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: cddSetFontSize(17),
              ),
            ),
            onTap: editOnTap,
          ),
          ListTile(
            title: Text("删除",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.primaryElementRed,
                  fontSize: cddSetFontSize(17),
                )),
            onTap: deleteOnTap,
          ),
          ListTile(
            title: Text("取消",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                  fontSize: cddSetFontSize(17),
                )),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  );
}

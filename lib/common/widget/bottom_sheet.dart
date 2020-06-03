import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

/// 底部弹出框: 编辑，删除，取消
Widget commonBottomSheetWidget({
  @required BuildContext context,
  @required VoidCallback tapEdit,
  @required VoidCallback tapDelete,
}) {
  return Container(
    height: sHeight(250),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "选择要执行的操作",
            style: TextStyle(
              fontSize: sSp(17),
              color: AppColor.secondaryTextColor.withOpacity(0.7),
            ),
          ),
          ListTile(
            title: Text(
              "编辑",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(17),
              ),
            ),
            onTap: tapEdit,
          ),
          ListTile(
            title: Text("删除",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.primaryElementRed,
                  fontSize: sSp(17),
                )),
            onTap: tapDelete,
          ),
          ListTile(
            title: Text("取消",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                  fontSize: sSp(17),
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

// 更改头像底部弹出框：相机、相册、默认
Widget chooseAvatarBottomSheetWidget({
  @required BuildContext context,
  @required VoidCallback tapCamera,
  @required VoidCallback tapGallery,
  @required VoidCallback tapDefault,
}) {
  return Container(
    height: sHeight(350),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "选择要执行的操作",
            style: TextStyle(
              fontSize: sSp(17),
              color: AppColor.secondaryTextColor.withOpacity(0.7),
            ),
          ),
          ListTile(
            title: Text(
              "拍摄",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(17),
              ),
            ),
            onTap: tapCamera,
          ),
          ListTile(
            title: Text(
              "相册",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(17),
              ),
            ),
            onTap: tapGallery,
          ),
          ListTile(
            title: Text(
              "默认头像",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(17),
              ),
            ),
            onTap: tapDefault,
          ),
          ListTile(
            title: Text(
              "取消",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryTextColor,
                fontSize: sSp(17),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  );
}

/// 选择相片：拍摄 / 本地相册
Widget choosePhotoBottomSheetWidget({
  @required BuildContext context,
  @required VoidCallback tapCamera,
  @required VoidCallback tapGallery,
}) {
  return Container(
    height: sHeight(250),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "选择要执行的操作",
            style: TextStyle(
              fontSize: sSp(17),
              color: AppColor.secondaryTextColor.withOpacity(0.7),
            ),
          ),
          ListTile(
            title: Text(
              "拍摄",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(17),
              ),
            ),
            onTap: tapCamera,
          ),
          ListTile(
            title: Text(
              "相册",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(17),
              ),
            ),
            onTap: tapGallery,
          ),
          ListTile(
            title: Text(
              "取消",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryTextColor,
                fontSize: sSp(17),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  );
}

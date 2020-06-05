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
          topLeft: Radius.circular(18), topRight: Radius.circular(18)),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: sHeight(5),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          _bottomSheetRow(context, Iconfont.bianji1, "编辑宠物信息", tapEdit),
          _bottomSheetRow(context, Iconfont.shanchu, "删除该宠物", tapDelete),
          _bottomSheetRow(context, Icons.close, "取消", () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    ),
  );
}

Widget _bottomSheetRow(
    BuildContext context, IconData iconData, String text, Function onPressed) {
  return Expanded(
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sWidth(20)),
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: AppColor.dark.withOpacity(.9),
            ),
            SizedBox(width: sWidth(20)),
            Text(
              text,
              style: TextStyle(
                color: AppColor.dark.withOpacity(.9),
                fontSize: sSp(17),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
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
    height: sHeight(330),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: sHeight(5),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          _bottomSheetRow(context, Icons.photo_camera, "相机拍摄", tapCamera),
          _bottomSheetRow(context, Icons.collections, "本地相册", tapGallery),
          _bottomSheetRow(context, Icons.scatter_plot, "默认头像", tapDefault),
          _bottomSheetRow(context, Icons.close, "取消", () {
            Navigator.of(context).pop();
          }),
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
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: sHeight(5),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          _bottomSheetRow(context, Icons.photo_camera, "相机拍摄", tapCamera),
          _bottomSheetRow(context, Icons.collections, "本地相册", tapGallery),
          _bottomSheetRow(context, Icons.close, "取消", () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    ),
  );
}

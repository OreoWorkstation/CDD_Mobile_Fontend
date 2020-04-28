import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';

class DeleteConfirmDialog extends Dialog {
  final title;
  final handleDelete;
  DeleteConfirmDialog(this.title, this.handleDelete, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: cddSetWidth(250),
          height: cddSetHeight(350),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: Radii.k10pxRadius,
            ),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: cddSetHeight(200),
                margin: EdgeInsets.only(top: cddSetHeight(10)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/delete-confirm.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: cddSetHeight(13)),
              Text(
                title,
                style: TextStyle(
                  fontSize: cddSetFontSize(17),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: cddSetHeight(26)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: cddSetWidth(19)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    btnFlatButtonWidget(
                      onPressed: () => Navigator.of(context).pop(),
                      bgColor: AppColor.secondaryElement,
                      width: 84,
                      height: 40,
                      title: "取消",
                      fontSize: 13,
                    ),
                    btnFlatButtonWidget(
                      onPressed: () {},
                      bgColor: AppColor.primaryElementRed,
                      width: 84,
                      height: 40,
                      title: "删除",
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

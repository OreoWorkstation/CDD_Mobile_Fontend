import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/color.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/button.dart';
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
          width: sWidth(250),
          height: sHeight(350),
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
                height: sHeight(200),
                margin: EdgeInsets.only(top: sHeight(10)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/state/delete-confirm.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: sHeight(13)),
              Text(
                title,
                style: TextStyle(
                  fontSize: sSp(17),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: sHeight(26)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sWidth(19)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    primaryBtn(
                      onPressed: () => Navigator.of(context).pop(),
                      bgColor: AppColor.secondaryElement,
                      width: 84,
                      height: 40,
                      title: "取消",
                      fontSize: 13,
                    ),
                    primaryBtn(
                      onPressed: handleDelete,
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

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {

  const BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.hiddenTitle = false,
    @required this.child
  }) : super(key : key);

  final String title;
  final VoidCallback onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {

    var dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          hiddenTitle ? '' : title,
          style: TextStyles.textBold18,
        ),
      ),
    );

    var bottomButton = Row(
      children: <Widget>[
        _DialogButton(
          text: '取消',
          textColor: Colours.text_gray,
          // TODO
          //onPressed: () => NavigatorUtils.goBack(context),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(),
        ),
        _DialogButton(
          text: '确定',
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
        ),
      ],
    );

    var body = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap8,
          Gaps.line,
          bottomButton,
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 270.0,
            child: body,
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {

  const _DialogButton({
    Key key,
    this.text,
    this.textColor,
    this.onPressed,
  }): super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48.0,
        child: FlatButton(
          child: Text(
            text,
            style: TextStyle(fontSize: Dimens.font_sp18),
          ),
          textColor: textColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

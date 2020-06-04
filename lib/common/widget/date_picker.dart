import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

/// 选择出生日期，年-月-日，底部弹窗
Widget cddDatePickerWidget({
  @required BuildContext context,
  @required DateTime dt,
  @required PickerConfirmCallback onConfirm,
  bool canTap = true,
}) {
  return GestureDetector(
    onTap: () {
      if (canTap)
        Picker(
          cancelText: "取消",
          confirmText: "确认",
          adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD,
            isNumberMonth: true,
            yearSuffix: "年",
            monthSuffix: "月",
            daySuffix: "日",
            value: dt,
          ),
          cancelTextStyle: TextStyle(
            color: AppColor.primary,
            fontSize: sSp(16),
          ),
          confirmTextStyle: TextStyle(
            color: AppColor.primary,
            fontSize: sSp(16),
          ),
          selectedTextStyle: TextStyle(color: AppColor.primary),
          title: Text(
            "请选择日期",
            style: TextStyle(color: AppColor.dark),
          ),
          onConfirm: onConfirm,
        ).showModal(context);
    },
    child: Text(
      cddFormatBirthday(dt),
      style: TextStyle(
        color: AppColor.dark,
        fontWeight: FontWeight.w500,
        fontSize: sSp(16),
        letterSpacing: 0.6,
      ),
    ),
  );
}

class DatePickerWidget extends StatefulWidget {
  final DateTime dt;
  DatePickerWidget({Key key, this.dt}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _dt;

  @override
  void initState() {
    _dt = widget.dt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Picker(
          cancelText: "取消",
          confirmText: "确认",
          adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD,
            isNumberMonth: true,
            yearSuffix: "年",
            monthSuffix: "月",
            daySuffix: "日",
            value: _dt,
          ),
          cancelTextStyle: TextStyle(
            color: AppColor.primaryElement,
            fontSize: Picker.DefaultTextSize,
          ),
          confirmTextStyle: TextStyle(
            color: AppColor.primaryElement,
            fontSize: Picker.DefaultTextSize,
          ),
          selectedTextStyle: TextStyle(color: AppColor.primaryElement),
          title: Text("请选择日期"),
          onConfirm: (Picker picker, List value) {
            setState(() {
              _dt = (picker.adapter as DateTimePickerAdapter).value;
              print(_dt);
            });
          },
        ).showModal(context);
      },
      child: Text(
        cddFormatBirthday(_dt),
        style: TextStyle(
          color: AppColor.secondaryTextColor.withOpacity(0.6),
          fontSize: 17,
        ),
      ),
    );
  }
}

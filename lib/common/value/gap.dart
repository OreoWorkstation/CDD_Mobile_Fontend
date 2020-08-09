import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/dimens.dart';
import 'package:flutter/material.dart';

/// 间隔
class Gaps {

  /// 水平间隔
  static Widget hGap4 = SizedBox(width: sWidth(Dimens.gap_dp4));
  static Widget hGap5 = SizedBox(width: sWidth(Dimens.gap_dp5));
  static Widget hGap8 = SizedBox(width: sWidth(Dimens.gap_dp8));
  static Widget hGap10 = SizedBox(width: sWidth(Dimens.gap_dp10));
  static Widget hGap12 = SizedBox(width: sWidth(Dimens.gap_dp12));
  static Widget hGap15 = SizedBox(width: sWidth(Dimens.gap_dp15));
  static Widget hGap16 = SizedBox(width: sWidth(Dimens.gap_dp16));
  static Widget hGap32 = SizedBox(width: sWidth(Dimens.gap_dp32));

  /// 垂直间隔
  static Widget vGap4 = SizedBox(height: sHeight(Dimens.gap_dp4));
  static Widget vGap5 = SizedBox(height: sHeight(Dimens.gap_dp5));
  static Widget vGap8 = SizedBox(height: sHeight(Dimens.gap_dp8));
  static Widget vGap10 = SizedBox(height: sHeight(Dimens.gap_dp10));
  static Widget vGap12 = SizedBox(height: sHeight(Dimens.gap_dp12));
  static Widget vGap15 = SizedBox(height: sHeight(Dimens.gap_dp15));
  static Widget vGap16 = SizedBox(height: sHeight(Dimens.gap_dp16));
  static Widget vGap24 = SizedBox(height: sHeight(Dimens.gap_dp24));
  static Widget vGap32 = SizedBox(height: sHeight(Dimens.gap_dp32));
  static Widget vGap50 = SizedBox(height: sHeight(Dimens.gap_dp50));

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static Widget line = const Divider();

  static Widget vLine = SizedBox(
    width: sWidth(0.6),
    height: sHeight(24.0),
    child: const VerticalDivider(),
  );

  static const Widget emptyWidget = const SizedBox.shrink();
}

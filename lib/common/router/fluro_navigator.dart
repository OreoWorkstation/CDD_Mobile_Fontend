import 'package:cdd_mobile_frontend/common/router/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void push(
    BuildContext context,
    String path, {
    bool replace = false,
    bool clearStack = false,
  }) {
    unfocus();
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  static void pushResult(
    BuildContext context,
    String path,
    Function(Object) function, {
    bool replace = false,
    bool clearStack = false,
  }) {
    unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      if (result == null) {
         return ;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  static void goBack(BuildContext context) {
    unfocus();
    Navigator.of(context).pop();
  }

  static void goBackWithParams(BuildContext context, result) {
    unfocus();
    Navigator.of(context).pop(result);
  }
}

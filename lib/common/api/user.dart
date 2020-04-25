import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 用户相关API
class UserAPI {
  /// 登录
  static Future<Response> login({
    // @required BuildContext context,
    UserLoginRequestEntity params,
  }) async {
    var response = await HttpUtil().post(
      "/login",
      // context: context,
      params: params,
    );
    return response;
  }

  /// 注册
  static Future<Response> register({
    @required BuildContext context,
    UserRegisterRequestEntity params,
  }) async {
    var response = await HttpUtil().post(
      "/register",
      params: params,
    );
    return response;
  }
}

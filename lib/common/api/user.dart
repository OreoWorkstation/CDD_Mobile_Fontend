import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 用户相关API
class UserAPI {
  /// 登录
  static Future<APIResponse<int>> login({
    // @required BuildContext context,
    UserLoginRequestEntity params,
  }) {
    return HttpUtil().post("/login", params: params).then((response) {
      if (response.statusCode == 200) {
        if (response.data['code'] == 0)
          return APIResponse<int>(data: response.data['data']);
        else
          return APIResponse<int>(
              error: true, errorMessage: response.data['msg']);
      }
      return APIResponse<int>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<int>(error: true, errorMessage: "An error occured");
    });
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

  /// 获取用户信息
  static Future<APIResponse<UserInfoEntity>> getUserInfo(int userId) {
    return HttpUtil().get("/user/$userId").then((response) {
      if (response.statusCode == 200) {
        if (response.data['code'] == 0)
          return APIResponse<UserInfoEntity>(
              data: UserInfoEntity.fromJson(response.data['data']));
        else
          return APIResponse<UserInfoEntity>(
              error: true, errorMessage: "An error occured");
      }
      return APIResponse<UserInfoEntity>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<UserInfoEntity>(
          error: true, errorMessage: "An error occured");
    });
  }
}

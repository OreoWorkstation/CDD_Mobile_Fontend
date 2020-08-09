import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class InstantAPI {
  /// 获取热门动态
  static Future<APIResponse<List<InstantVO>>> fetchHotInstant() async {
    return HttpUtil().get("/instant/hot", params: {
      "user_id": int.parse(Global.accessToken),
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<InstantVO>>(
          data: data.map((item) => InstantVO.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<InstantVO>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<InstantVO>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取关注的人动态
  static Future<APIResponse<List<InstantVO>>> fetchFollowInstant() async {
    return HttpUtil().get("/instant/follow", params: {
      "user_id": int.parse(Global.accessToken),
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<InstantVO>>(
          data: data.map((item) => InstantVO.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<InstantVO>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<InstantVO>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 添加动态
  static Future<APIResponse<bool>> insertInstant({
    @required InstantEntity instant,
  }) async {
    return HttpUtil()
        .post("/instant", params: instant.toJson())
        .then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  /// 删除动态
  static Future<APIResponse<bool>> deleteInstant({
    @required int instantId,
  }) async {
    return HttpUtil().delete("/instant", params: {
      "instant_id": instantId,
    }).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }
}
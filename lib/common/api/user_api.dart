import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:dio/dio.dart';

/// 用户相关API
class UserAPI {
  /// 登录
  static Future<APIResponse<int>> login({
    // @required BuildContext context,
    Map<String, dynamic> params,
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
    Map<String, dynamic> params,
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

  /// 获取用户空间信息
  static Future<APIResponse<UserZoneEntity>> getUserZone(int userId) {
    return HttpUtil().get("/user/$userId/zone").then((response) {
      if (response.statusCode == 200) {
        if (response.data['code'] == 0)
          return APIResponse<UserZoneEntity>(
              data: UserZoneEntity.fromJson(response.data['data']));
        else
          return APIResponse<UserZoneEntity>(
              error: true, errorMessage: "An error occured");
      }
      return APIResponse<UserZoneEntity>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<UserZoneEntity>(
          error: true, errorMessage: "An error occured");
    });
  }

  /// 获取关注的人列表
  static Future<APIResponse<List<FollowReponseEntity>>> fetchFollowList(
      int userId) {
    return HttpUtil().get("/user/$userId/follow").then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<FollowReponseEntity>>(
          data: data.map((item) => FollowReponseEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<FollowReponseEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<FollowReponseEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取粉丝列表
  static Future<APIResponse<List<FollowReponseEntity>>> fetchFansList(
      int userId) {
    return HttpUtil().get("/user/$userId/fans").then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<FollowReponseEntity>>(
          data: data.map((item) => FollowReponseEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<FollowReponseEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<FollowReponseEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 关注/取关
  static Future<APIResponse<bool>> followUser(FollowEntity follow) {
    print(follow.id);
    print(follow.userId);
    print(follow.followedId);
    return HttpUtil().post("/follow", params: follow.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }
}

import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class FeedAPI {
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

  /// 获取评论列表
  static Future<APIResponse<List<CommentEntity>>> getCommentList({
    int instantId,
  }) {
    return HttpUtil().get("/comment", params: {
      "instant_id": instantId,
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<CommentEntity>>(
          data: data.map((item) => CommentEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<CommentEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<CommentEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 添加评论
  static Future<APIResponse<bool>> insertComment({
    Comment comment,
  }) {
    return HttpUtil()
        .post("/comment", params: comment.toJson())
        .then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  /// 点赞 / 取消点赞
  static Future<APIResponse<bool>> likeInstant(Map<String, dynamic> params) {
    return HttpUtil().post("/like", params: params).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }
}

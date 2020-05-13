import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';

class CommentAPI {
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

  /// 获取单个评论
  static Future<APIResponse<CommentEntity>> getCommentByCommentId({
    int commentId,
  }) {
    return HttpUtil().get("/comment/$commentId").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<CommentEntity>(
            data: CommentEntity.fromJson(response.data['data']));
      }
      return APIResponse<CommentEntity>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<CommentEntity>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 添加评论
  static Future<APIResponse<bool>> insertComment({
    CommentEntity comment,
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
}

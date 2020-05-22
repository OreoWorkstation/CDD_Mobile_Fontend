import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/model/browse_entity.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class ArticleAPI {
  /// 获取单个文章
  static Future<APIResponse<ArticleResponseEntity>> getArticle({
    int articleId,
  }) {
    return HttpUtil().get("/article/$articleId").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<ArticleResponseEntity>(
          data: ArticleResponseEntity.fromJson(response.data['data']),
        );
      }
      return APIResponse<ArticleResponseEntity>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取推荐文章列表
  static Future<APIResponse<List<ArticleResponseEntity>>>
      getRecommendArticleList({
    @required int userId,
  }) {
    return HttpUtil().get("/article/recommend", params: {
      "user_id": userId,
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<ArticleResponseEntity>>(
          data:
              data.map((item) => ArticleResponseEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取热门文章列表
  static Future<APIResponse<List<ArticleResponseEntity>>> getHotArticleList() {
    return HttpUtil().get("/article/hot").then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<ArticleResponseEntity>>(
          data:
              data.map((item) => ArticleResponseEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取分类文章列表
  static Future<APIResponse<List<ArticleResponseEntity>>>
      getCategoryArticleList({
    int category,
  }) {
    return HttpUtil().get("/article/category/$category").then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<ArticleResponseEntity>>(
          data:
              data.map((item) => ArticleResponseEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<ArticleResponseEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  static Future<APIResponse<bool>> postBrowse({BrowseEntity browse}) {
    return HttpUtil().post("browse", params: browse.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }
}

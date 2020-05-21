import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class PhotoAPI {
  /// 获取相片列表
  static Future<APIResponse<List<PhotoEntity>>> getPhotoList({
    int petId,
  }) {
    return HttpUtil().get("/photo", params: {
      "pet_id": petId,
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<PhotoEntity>>(
          data: data.map((item) => PhotoEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<PhotoEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<PhotoEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取单个相片
  static Future<APIResponse<PhotoEntity>> getPhotoByPhotoId({
    int photoId,
  }) {
    return HttpUtil().get("/photo/$photoId").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<PhotoEntity>(
            data: PhotoEntity.fromJson(response.data['data']));
      }
      return APIResponse<PhotoEntity>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<PhotoEntity>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 添加相片
  static Future<APIResponse<bool>> insertPhoto({
    PhotoEntity photo,
  }) {
    return HttpUtil().post("/photo", params: photo.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  /// 删除相片
  static Future<APIResponse<bool>> deletePhoto({
    int photoId,
  }) {
    return HttpUtil().delete("/photo", params: {
      "photo_id": photoId,
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

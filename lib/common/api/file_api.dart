import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:dio/dio.dart';

class FileAPI {
  // 上传图片
  static Future<APIResponse<String>> uploadImage({
    MultipartFile imagePath,
  }) {
    return HttpUtil().postForm("/upload", params: {
      "file": imagePath,
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.data);
        return APIResponse<String>(data: response.data['data']);
      }
      return APIResponse<String>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<String>(
          error: true, errorMessage: "An error occurred");
    });
  }
}

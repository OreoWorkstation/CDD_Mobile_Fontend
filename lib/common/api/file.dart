import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:dio/dio.dart';

class FileAPI {
  static Future<APIResponse<String>> upload({
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

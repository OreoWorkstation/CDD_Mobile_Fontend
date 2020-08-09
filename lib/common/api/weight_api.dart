import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class WeightAPI {
  // 获取体重列表
  static Future<APIResponse<List<WeightEntity>>> getWeightList({
    int petId,
  }) {
    return HttpUtil().get("/weight", params: {
      "pet_id": petId,
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<WeightEntity>>(
            data: data.map((item) => WeightEntity.fromJson(item)).toList());
      }
      return APIResponse<List<WeightEntity>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<List<WeightEntity>>(
          error: true, errorMessage: "An error occured");
    });
  }

  // 获取单个体重
  static Future<APIResponse<WeightEntity>> getWeightByWeightId({
    int weightId,
  }) {
    return HttpUtil().get("weight/$weightId").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<WeightEntity>(
            data: WeightEntity.fromJson(response.data['data']));
      }
      return APIResponse<WeightEntity>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<WeightEntity>(
          error: true, errorMessage: "An error occured");
    });
  }

  // 插入体重
  static Future<APIResponse<bool>> insertWeight({
    WeightEntity weight,
  }) {
    return HttpUtil().post("/weight", params: weight.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    });
  }

  // 删除体重
  static Future<APIResponse<bool>> deleteWeight({
    int weightId,
  }) {
    return HttpUtil().delete("/weight", params: {
      "weight_id": weightId,
    }).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    });
  }

  // 更新体重
  static Future<APIResponse<bool>> updateWeight({
    WeightEntity weight,
  }) {
    return HttpUtil().put("/weight", params: weight.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    });
  }
}

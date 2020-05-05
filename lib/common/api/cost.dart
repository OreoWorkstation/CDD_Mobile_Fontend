import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';

class CostAPI {
  /// 获取消费列表
  static Future<APIResponse<List<CostEntity>>> getCostList({
    int petId,
  }) {
    return HttpUtil().get("/cost", params: {
      "pet_id": petId,
    }).then((response) {
      // print(response.data['data']);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<CostEntity>>(
          data: data.map((item) => CostEntity.fromJson(item)).toList(),
        );
      }
      return APIResponse<List<CostEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<CostEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 获取单个消费
  static Future<APIResponse<CostEntity>> getCostByCostId({
    int costId,
  }) {
    return HttpUtil().get("/cost/$costId").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<CostEntity>(
            data: CostEntity.fromJson(response.data['data']));
      }
      return APIResponse<CostEntity>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<CostEntity>(
          error: true, errorMessage: "An error occurred");
    });
  }

  /// 添加消费
  static Future<APIResponse<bool>> insertCost({
    CostEntity cost,
  }) {
    return HttpUtil().post("/cost", params: cost.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  /// 删除消费
  static Future<APIResponse<bool>> deleteCost({
    int costId,
  }) {
    return HttpUtil().delete("/cost", params: {
      "cost_id": costId,
    }).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  /// 更新消费
  static Future<APIResponse<bool>> updateCost({
    CostEntity cost,
  }) {
    return HttpUtil().put("/cost", params: cost.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }
}

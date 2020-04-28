import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';

class PetAPI {
  /// 获取宠物列表
  static Future<APIResponse<List<PetEntity>>> getPetList({
    int userId,
  }) {
    return HttpUtil().get("/pet", params: {
      "user_id": userId,
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<PetEntity>>(
            data: data.map((item) => PetEntity.fromJson(item)).toList());
      }
      return APIResponse<List<PetEntity>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<List<PetEntity>>(
          error: true, errorMessage: "An error occured");
    });
  }

  /// 获取单个宠物
  static Future<APIResponse<PetEntity>> getPetByPetId({
    int petId,
  }) {
    return HttpUtil().get("/pet/${petId.toString()}").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<PetEntity>(
            data: PetEntity.fromJson(response.data['data']));
      }
      return APIResponse<PetEntity>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<PetEntity>(
          error: true, errorMessage: "An error occured");
    });
  }

  /// 添加宠物
  static Future<APIResponse<bool>> insertPet({
    PetEntity pet,
  }) {
    return HttpUtil().post("/pet", params: pet.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    });
  }

  /// 删除宠物
  static Future<APIResponse<bool>> deletePet({int petId}) {
    return HttpUtil().delete("/pet", params: {
      "pet_id": petId,
    }).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    });
  }

  /// 更新宠物信息
  static Future<APIResponse<bool>> updatePet({PetEntity pet}) {
    return HttpUtil().put("/pet", params: pet.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    });
  }
}

import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:flutter/material.dart';

class PetAPI {
  /// 获取宠物列表
  static Future<List<PetEntity>> pets({
    int userId,
  }) async {
    var response = await HttpUtil().get("/pet", params: {
      "user_id": userId,
    });
    var data = response.data['data'] as List;
    return data.map((item) => PetEntity.fromJson(item)).toList();
  }
}

import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class PetEditProvider extends ViewStateModel {
  /// 更新宠物信息
  Future<bool> updatePet({
    @required PetEntity pet,
  }) async {
    setBusy();
    try {
      var response = await PetAPI.updatePet(pet: pet);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

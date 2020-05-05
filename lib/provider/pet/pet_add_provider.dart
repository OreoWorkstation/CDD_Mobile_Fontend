import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:flutter/material.dart';

class PetAddProvider extends ViewStateModel {
  /// 添加宠物
  Future<bool> addPet({
    @required String species,
    @required String avatar,
    @required String nickname,
    @required int gender,
    @required DateTime birthday,
    @required String intro,
  }) async {
    setBusy();
    PetEntity pet = PetEntity(
      userId: int.parse(Global.accessToken),
      species: species,
      avatar: avatar,
      nickname: nickname,
      gender: gender,
      birthday: birthday,
      introduction: intro,
    );
    try {
      var response = await PetAPI.insertPet(pet: pet);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        // _petList.add(pet);
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

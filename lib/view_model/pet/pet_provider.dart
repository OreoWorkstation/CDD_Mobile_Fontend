import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class PetProvider extends ViewStateModel {
  PetEntity _pet;

  PetEntity get pet => _pet;

  PetProvider(int petId) {
    fetchPetByPetId(petId: petId);
  }

  /// 获取单个宠物
  Future<bool> fetchPetByPetId({@required int petId}) async {
    setBusy();
    var response = await PetAPI.getPetByPetId(petId: petId);
    _pet = response.data;
    setIdle();
    return true;
  }

  /// 重新获取宠物，不需要petid
  Future<bool> fetchPet() async {
    setBusy();
    var response = await PetAPI.getPetByPetId(petId: _pet.id);
    _pet = response.data;
    setIdle();
    return true;
  }
}

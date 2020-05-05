import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:flutter/material.dart';

class PetProvider extends ViewStateModel {
  List<PetEntity> _petList;
  PetEntity _pet;

  List<PetEntity> get petList => _petList;
  PetEntity get pet => _pet;

  PetProvider() {
    fetchPetList();
  }

  /// 获取宠物列表
  Future<bool> fetchPetList() async {
    setBusy();
    try {
      var response = await PetAPI.getPetList(
        userId: int.parse(Global.accessToken), // userId为全局变量，保存在Token中
      );
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _petList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取单个宠物
  Future<bool> getPetByPetId({@required int petId}) async {
    var response = await PetAPI.getPetByPetId(petId: petId);
    _pet = response.data;
    notifyListeners();
  }

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

  /// 删除宠物
  Future<bool> deletePet(int petId) async {
    await PetAPI.deletePet(petId: petId);
    notifyListeners();
    return true;
  }

  /// 更新宠物信息
  Future<bool> updatePet({
    @required int petIndex,
    @required String avatar,
    @required String nickname,
    @required int gender,
    @required DateTime birthday,
    @required String intro,
  }) async {
    setBusy();
    PetEntity pet = _petList[petIndex];
    pet.avatar = avatar;
    pet.nickname = nickname;
    pet.gender = gender;
    pet.birthday = birthday;
    pet.introduction = intro;
    try {
      var response = await PetAPI.updatePet(pet: pet);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _petList[petIndex] = pet;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

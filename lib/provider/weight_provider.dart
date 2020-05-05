import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/provider/pet_provider.dart';
import 'package:flutter/material.dart';

class WeightProvider extends ViewStateModel {
  List<WeightEntity> _weightList;

  List<WeightEntity> get weightList => _weightList;

  /// 获取体重列表
  Future<bool> fetchWeightList(int petId) async {
    setBusy();
    try {
      var response = await WeightAPI.getWeightList(petId: petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _weightList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 添加体重
  Future<bool> addWeight({
    @required int petId,
    @required double weightValue,
    @required DateTime createTime,
  }) async {
    setBusy();
    WeightEntity weight = WeightEntity(
      petId: petId,
      weightValue: weightValue,
      createTime: createTime,
    );
    try {
      var response = await WeightAPI.insertWeight(weight: weight);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        fetchWeightList(petId);
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 删除体重
  Future<bool> deleteWeight({
    @required int weightIndex,
  }) async {
    await WeightAPI.deleteWeight(weightId: _weightList[weightIndex].id);
    _weightList.removeAt(weightIndex);
    notifyListeners();
    return true;
  }

  /// 更新体重
  Future<bool> updateWeight({
    @required int weightIndex,
    @required double weightValue,
    @required DateTime createTime,
  }) async {
    setBusy();
    WeightEntity weight = WeightEntity(
      id: _weightList[weightIndex].id,
      petId: _weightList[weightIndex].petId,
      weightValue: weightValue,
      createTime: createTime,
    );
    try {
      var response = await WeightAPI.updateWeight(weight: weight);
      if (response.error) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        fetchWeightList(_weightList[weightIndex].petId);
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class WeightAddProvider extends ViewStateModel {
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
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

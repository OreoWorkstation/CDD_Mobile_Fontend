import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

/// 体重的增，改
class WeightOperationProvider extends ViewStateModel {
  /// 添加体重
  Future<bool> addWeight({@required WeightEntity weight}) async {
    setBusy();
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

  /// 更新体重
  Future<bool> updateWeight({@required WeightEntity weight}) async {
    setBusy();
    try {
      var response = await WeightAPI.updateWeight(weight: weight);
      if (response.error) {
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

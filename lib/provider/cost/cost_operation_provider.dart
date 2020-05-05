import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

/// 消费的增，改
class CostOperationProvider extends ViewStateModel {
  /// 添加消费
  Future<bool> addCost({@required CostEntity cost}) async {
    setBusy();
    try {
      var response = await CostAPI.insertCost(cost: cost);
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

  /// 更新消费
  Future<bool> updateCost({@required CostEntity cost}) async {
    setBusy();
    try {
      var response = await CostAPI.updateCost(cost: cost);
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

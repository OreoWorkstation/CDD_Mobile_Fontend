import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class CostDeleteProvider extends ViewStateModel {
  /// 删除体重
  Future<bool> deleteCost({
    @required int costId,
  }) async {
    setBusy();
    await CostAPI.deleteCost(costId: costId);
    setIdle();
    return true;
  }
}

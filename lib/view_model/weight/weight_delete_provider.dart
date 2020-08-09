import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class WeightDeleteProvider extends ViewStateModel {
  /// 删除体重
  Future<bool> deleteWeight({
    @required int weightId,
  }) async {
    setBusy();
    await WeightAPI.deleteWeight(weightId: weightId);
    setIdle();
    return true;
  }
}

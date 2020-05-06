import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class DiaryDeleteProvider extends ViewStateModel {
  /// 删除日记
  Future<bool> deleteDiary({
    @required int diaryId,
  }) async {
    setBusy();
    await DiaryAPI.deleteDiary(diaryId: diaryId);
    setIdle();
    return true;
  }
}

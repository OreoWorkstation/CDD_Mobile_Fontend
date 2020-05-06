import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class DiaryOperationProvider extends ViewStateModel {
  /// 添加日记
  Future<bool> addDiary({@required DiaryEntity diary}) async {
    setBusy();
    try {
      var response = await DiaryAPI.insertDiary(diary: diary);
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

  /// 更新日记
  Future<bool> updateDiary({@required DiaryEntity diary}) async {
    setBusy();
    try {
      var response = await DiaryAPI.updateDiary(diary: diary);
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

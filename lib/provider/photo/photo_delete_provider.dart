import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class PhotoDeleteProvider extends ViewStateModel {
  /// 删除相片
  Future<bool> deletePhoto({
    @required int photoId,
  }) async {
    setBusy();
    await PhotoAPI.deletePhoto(photoId: photoId);
    setIdle();
    return true;
  }
}

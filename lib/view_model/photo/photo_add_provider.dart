import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class PhotoAddProvider extends ViewStateModel {
  /// 添加相片
  Future<bool> addPhoto({@required PhotoEntity photo}) async {
    setBusy();
    await PhotoAPI.insertPhoto(photo: photo);
    setIdle();
    return true;
    /*
    // setBusy();
    try {
      var response = await PhotoAPI.insertPhoto(photo: photo);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        // setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
    */
  }
}

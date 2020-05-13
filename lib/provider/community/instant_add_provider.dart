import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:flutter/material.dart';

class InstantAddProvider extends ViewStateModel {
  Future<bool> addInstnt({@required InstantEntity instant}) async {
    setBusy();
    try {
      var response = await InstantAPI.insertInstant(instant: instant);
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

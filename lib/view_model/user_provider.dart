import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/net/base_state.dart';
import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/user_entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ViewStateModel {
  UserInfoEntity _userInfo;
  int _userId;

  UserInfoEntity get userInfo => _userInfo;
  int get userId => _userId;

  /// 登录
  Future<bool> signIn(String account, String password) async {
    setBusy();
    try {
      var res = await UserAPI.login(params: {
        "account": account,
        "password": password,
      });
      if (res.error == true) {
        setError(null, null, message: res.errorMessage);
        return false;
      } else {
        Global.saveToken(res.data.toString());
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

}

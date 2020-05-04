import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';

/// 用户 Provider
class UserProvider extends ViewStateModel {
  UserInfoEntity _userInfo;

  UserInfoEntity get userInfo => _userInfo;

  /// 登录
  Future<bool> signIn(String account, String password) async {
    setBusy();
    UserLoginRequestEntity params = UserLoginRequestEntity(
      account: account,
      password: password,
    );
    try {
      var res = await UserAPI.login(params: params);
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

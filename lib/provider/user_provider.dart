import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';

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

    var res = await UserAPI.login(params: params);
  }
}

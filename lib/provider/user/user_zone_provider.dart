import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';

class UserZoneProvider extends ViewStateModel {
  UserZoneEntity _userZone;

  UserZoneEntity get userZone => _userZone;

  UserZoneProvider(int userId) {
    fetchUserZone(userId);
  }

  Future<bool> fetchUserZone(int userId) async {
    setBusy();
    try {
      var response = await UserAPI.getUserZone(userId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _userZone = response.data;

        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

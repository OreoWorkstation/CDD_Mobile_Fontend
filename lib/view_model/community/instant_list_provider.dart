import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class InstantListProvider extends ViewStateModel {
  List<InstantVO> _instantVOList0;
  List<InstantVO> _instantVOList1;

  List<InstantVO> get instantVOList0 => _instantVOList0;
  List<InstantVO> get instantVOList1 => _instantVOList1;

  InstantListProvider() {
    fetchHotInstant();

    fetchFollowInstant();
  }

  Future<bool> fetchAllData() async {
    fetchHotInstant();
    fetchFollowInstant();
    notifyListeners();
    return true;
  }

  /// 获取热门动态
  Future<bool> fetchHotInstant() async {
    setBusy();
    try {
      var response = await InstantAPI.fetchHotInstant();
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _instantVOList0 = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取关注的人的动态
  Future<bool> fetchFollowInstant() async {
    setBusy();
    try {
      var response = await InstantAPI.fetchFollowInstant();
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _instantVOList1 = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

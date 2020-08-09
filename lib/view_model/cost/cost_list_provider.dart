import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class CostListProvider extends ViewStateModel {
  List<CostEntity> _costList;
  int _petId;

  List<CostEntity> get costList => _costList;
  int get petId => _petId;

  CostListProvider(int petId) {
    _petId = petId;
    fetchCostList(petId);
  }

  /// 获取消费列表
  Future<bool> fetchCostList(int petId) async {
    setBusy();
    try {
      var response = await CostAPI.getCostList(petId: petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _costList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取消费列表,不需要petId
  Future<bool> fetchCostListWithoutPetId() async {
    setBusy();
    try {
      var response = await CostAPI.getCostList(petId: _petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _costList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

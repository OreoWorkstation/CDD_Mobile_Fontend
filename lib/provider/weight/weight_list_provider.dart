import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';

class WeightListProvider extends ViewStateModel {
  List<WeightEntity> _weightList;
  int _petId;

  List<WeightEntity> get weightList => _weightList;
  int get petId => _petId;

  WeightListProvider(int petId) {
    _petId = petId;
    fetchWeightList(petId);
  }

  /// 获取体重列表
  Future<bool> fetchWeightList(int petId) async {
    setBusy();
    try {
      var response = await WeightAPI.getWeightList(petId: petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _weightList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取体重列表,不需要petId
  Future<bool> fetchWeightListWithoutPetId() async {
    setBusy();
    try {
      var response = await WeightAPI.getWeightList(petId: _petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _weightList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

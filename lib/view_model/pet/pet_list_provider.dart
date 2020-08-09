import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class PetListProvider extends ViewStateModel {
  List<PetEntity> _petList;

  List<PetEntity> get petList => _petList;

  PetListProvider() {
    fetchPetList();
  }

  clearPetList() {
    _petList = [];
  }

  /// 获取宠物列表
  Future<bool> fetchPetList() async {
    setBusy();
    try {
      var response = await PetAPI.getPetList(
        userId: int.parse(Global.accessToken), // userId为全局变量，保存在Token中
      );
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _petList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

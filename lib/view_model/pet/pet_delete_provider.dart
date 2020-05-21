import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';

class PetDeleteProvider extends ViewStateModel {
  /// 删除宠物
  Future<bool> deletePet(int petId) async {
    setBusy();
    await PetAPI.deletePet(petId: petId);
    setIdle();
    return true;
  }
}

import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';

class PhotoListProvider extends ViewStateModel {
  List<PhotoEntity> _photoList;
  int _petId;

  List<PhotoEntity> get photoList => _photoList;
  int get petId => _petId;

  PhotoListProvider(int petId) {
    _petId = petId;
    fetchPhotoList(petId);
  }

  /// 获取相片列表
  Future<bool> fetchPhotoList(int petId) async {
    setBusy();
    try {
      var response = await PhotoAPI.getPhotoList(petId: petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _photoList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取相片列表,不需要petId
  Future<bool> fetchPhotoListWithoutPetId() async {
    setBusy();
    try {
      var response = await PhotoAPI.getPhotoList(petId: _petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _photoList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

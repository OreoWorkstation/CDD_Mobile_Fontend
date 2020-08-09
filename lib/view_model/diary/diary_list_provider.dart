import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class DiaryListProvider extends ViewStateModel {
  List<DiaryEntity> _diaryList;
  int _petId;

  List<DiaryEntity> get diaryList => _diaryList;
  int get petId => _petId;

  DiaryListProvider(int petId) {
    _petId = petId;
    fetchDiaryList(petId);
  }

  /// 获取日记列表
  Future<bool> fetchDiaryList(int petId) async {
    setBusy();
    try {
      var response = await DiaryAPI.getDiaryList(petId: petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _diaryList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取日记列表,不需要petId
  Future<bool> fetchDiaryListWithoutPetId() async {
    setBusy();
    try {
      var response = await DiaryAPI.getDiaryList(petId: _petId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _diaryList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

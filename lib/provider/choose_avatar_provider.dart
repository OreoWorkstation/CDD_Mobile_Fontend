import 'dart:io';

import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ChooseAvatarProvider extends ViewStateModel {
  String _avatarNetworkPath = "";

  String get avatarNetworkPath => _avatarNetworkPath;

  ChooseAvatarProvider(this._avatarNetworkPath);

  // 设置图片路径为空
  setDefault(String imagePath) {
    _avatarNetworkPath = imagePath;
    notifyListeners();
  }

  // 相机拍照
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      getNetworkPath(image);
    }
  }

  // 相册
  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      getNetworkPath(image);
    }
  }

  // 上传图片，并获取网络地址
  Future<bool> getNetworkPath(File file) async {
    setBusy();
    try {
      var response = await FileAPI.uploadImage(
        imagePath: await MultipartFile.fromFile(file.path),
      );
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      }
      _avatarNetworkPath = response.data;
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

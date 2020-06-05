import 'dart:io';

import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/common/util/random.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageProvider extends ViewStateModel {
  String _imageNetworkPath = "";
  String _oldImageNetworkPath = "";

  String get imageNetworkPath => _imageNetworkPath;
  String get oldImageNetworkPath => _oldImageNetworkPath;

  ChooseImageProvider(this._imageNetworkPath);

  // 设置图片路径为空
  setDefault(String imagePath) {
    _imageNetworkPath = imagePath;
    notifyListeners();
  }

  clearImagePath() {
    _imageNetworkPath = "";
    notifyListeners();
  }

  // 相机拍照
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await getNetworkPath(image);
    } else {
      _imageNetworkPath = "";
    }
  }

  // 相册
  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await getNetworkPath(image);
    } else {
      _imageNetworkPath = "";
    }
  }

  // 上传图片，并获取网络地址
  Future<bool> getNetworkPath(File file) async {
    setBusy();
    try {
      print(file.lengthSync().toString());
      var result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          Directory.systemTemp.path +
              '/userava' +
              generateRandomNickname() +
              '.jpg',
          quality: 10);
      print(result.lengthSync().toString());
      var response = await FileAPI.uploadImage(
        imagePath: await MultipartFile.fromFile(result.path),
      );
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      }
      _oldImageNetworkPath = _imageNetworkPath;
      _imageNetworkPath = response.data;
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

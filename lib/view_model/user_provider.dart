import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/net/base_state.dart';
import 'package:cdd_mobile_frontend/common/net/http.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/user_entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ViewStateModel {
  UserInfoEntity _userInfo;
  int _userId;
  int _profileUserId;
  int _isFollow;
  List<UserInfoEntity> _followList;
  List<UserInfoEntity> _fansList;
  UserZoneEntity _userZone;

  UserInfoEntity get userInfo => _userInfo;
  int get userId => _userId;
  List<UserInfoEntity> get followList => _followList;
  List<UserInfoEntity> get fansList => _fansList;
  int get isFollow => _isFollow;
  UserZoneEntity get userZone => _userZone;

  changePetNumber(int delt) {
    _userInfo.petNumber += delt;
    notifyListeners();
  }

  changeInstantNumber(int delt) {
    _userInfo.instantNumber += delt;
    notifyListeners();
  }

  changeFollowNumber(int delt) {
    _userInfo.followNumber += delt;
    notifyListeners();
  }

  changeFansNumber(int delt) {
    _userInfo.fansNumber += delt;
    notifyListeners();
  }

  /// 登录
  Future<bool> signIn(String account, String password) async {
    setBusy();
    try {
      var res = await UserAPI.login(params: {
        "account": account,
        "password": password,
      });
      if (res.error == true) {
        setError(null, null, message: res.errorMessage);
        return false;
      } else {
        _userId = res.data;
        Global.saveToken(res.data.toString());
        await fetchUserInfo();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 获取用户信息
  Future<bool> fetchUserInfo() async {
    setBusy();
    var res = await UserAPI.getUserInfo(int.parse(Global.accessToken));
    _userInfo = res.data;
    setIdle();
    return true;
  }

  /// 获取关注的人列表
  Future<bool> fetchFollowList() async {
    setBusy();
    var res = await UserAPI.fetchFollowList(_userId);
    _followList = res.data;
    setIdle();
    return true;
  }

  /// 获取粉丝列表
  Future<bool> fetchFansList() async {
    setBusy();
    var res = await UserAPI.fetchFansList(_userId);
    _fansList = res.data;
    setIdle();
    return true;
  }

  /// 关注/取关
  followUser({@required int followedId, bool unFollow = false}) async {
    if (unFollow) {
      _userInfo.followNumber--;
      _isFollow = 0;
      await UserAPI.followUser({
        "user_id": _userId,
        "followed_id": followedId,
        "type": 1,
      });
    } else {
      _isFollow = 1;
      _userInfo.followNumber++;
      await UserAPI.followUser({
        "user_id": _userId,
        "followed_id": followedId,
        "type": 0,
      });
    }
    notifyListeners();
  }

  /// 获取用户空间信息
  Future<bool> fetchUserZone(int uid) async{
    setBusy();
    _profileUserId = uid;
    if (_profileUserId == _userId) {
      _isFollow = -1;
    } else {
      if (_followList != null && _followList.isNotEmpty) {
        if (_followList.any((item) => item.id == uid)) {
          _isFollow = 1;
        } else {
          _isFollow = 0;
        }
      } else {
        _isFollow = 0;
      }
    }
    var res = await UserAPI.getUserZone(_profileUserId);
    _userZone = res.data;
    setIdle();
    return true;
  }
}

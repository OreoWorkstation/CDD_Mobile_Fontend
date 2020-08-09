import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ViewStateModel {
  UserInfoEntity _userInfo;
  UserInfoEntity _userProfileInfo;
  int _userId;
  int _userProfileId;
  int _isFollow;
  List<FollowReponseEntity> _followList;
  List<FollowReponseEntity> _fansList;
  UserZoneEntity _userZone;
  bool _isLoggedUser;

  UserInfoEntity get userInfo => _userInfo;
  UserInfoEntity get userProfileInfo => _userProfileInfo;
  int get userId => _userId;
  int get userProfileId => _userProfileId;
  List<FollowReponseEntity> get followList => _followList;
  List<FollowReponseEntity> get fansList => _fansList;
  int get isFollow => _isFollow;
  UserZoneEntity get userZone => _userZone;
  bool get isLoggedUser => _isLoggedUser;

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

  /// 注册
  Future<bool> register(String account, String password) async {
    print(account);
    print(password);
    setBusy();
    try {
      var res = await UserAPI.register(params: {
        "account": account,
        "password": password,
        "nickname": generateRandomNickname().toString(),
        "avatar":
            "https://images.unsplash.com/photo-1588636196535-5d60ffae6aef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
      });
      if (res.error == true) {
        setError(null, null, message: res.errorMessage);
        return false;
      } else {
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  Future<bool> updateUserInfo(String avatar, String nickname,
      String introduction, int gender, String address) async {
    _userInfo.avatar = avatar;
    _userInfo.nickname = nickname;
    _userInfo.introduction = introduction;
    _userInfo.gender = gender;
    _userInfo.address = address;
    print(_userInfo.introduction);
    setBusy();
    await UserAPI.updateUserInfo(_userInfo);
    setIdle();
    return true;
  }

  /// 获取用户信息
  Future<bool> fetchUserInfo() async {
    setBusy();
    var res = await UserAPI.getUserInfo(int.parse(Global.accessToken));
    _userInfo = res.data;
    setIdle();
    return true;
  }

  /// 获取用户资料信息
  Future<bool> fetchUserProfile(int userProfileId) async {
    setBusy();
    var res = await UserAPI.getUserInfo(userProfileId);
    _userProfileInfo = res.data;
    _userProfileId = _userProfileInfo.id;
    _isLoggedUser = _userProfileId == _userId;
    var res1 = await UserAPI.fetchFollowList(int.parse(Global.accessToken));
    _followList = res1.data;
    print(_followList.length);
    if (_userProfileId == _userId) {
      _isFollow = -1;
    } else {
      if (_followList != null && _followList.isNotEmpty) {
        if (_followList.any((item) => item.userId == userProfileId)) {
          _isFollow = 1;
        } else {
          _isFollow = 0;
        }
      } else {
        _isFollow = 0;
      }
    }
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
      await UserAPI.followUser(FollowEntity(
        id: 0,
        userId: _userId,
        followedId: followedId,
      ));
    } else {
      _isFollow = 1;
      _userInfo.followNumber++;
      await UserAPI.followUser(FollowEntity(
        id: 0,
        userId: _userId,
        followedId: followedId,
      ));
    }
    notifyListeners();
  }

  /// 获取用户空间信息
  Future<bool> fetchUserZone(int uid) async {
    setBusy();
    var res1 = await UserAPI.fetchFollowList(int.parse(Global.accessToken));
    _followList = res1.data;
    print(_followList.length);
    _userProfileId = uid;
    if (_userProfileId == _userId) {
      _isFollow = -1;
    } else {
      if (_followList != null && _followList.isNotEmpty) {
        if (_followList.any((item) => item.userId == uid)) {
          _isFollow = 1;
        } else {
          _isFollow = 0;
        }
      } else {
        _isFollow = 0;
      }
    }
    var res = await UserAPI.getUserZone(_userProfileId);
    _userZone = res.data;
    var res2 = await UserAPI.getUserInfo(userProfileId);
    _userProfileInfo = res2.data;
    _userProfileId = _userProfileInfo.id;
    _isLoggedUser = _userProfileId == _userId;
    setIdle();
    return true;
  }
}

import 'package:cdd_mobile_frontend/common/api/feed_api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:flutter/material.dart';

class FeedProvider extends ViewStateModel {
  List<InstantVO> _instantList;
  List<CommentEntity> _commentList;
  InstantVO _instant;
  int _index;

  List<InstantVO> get instantList => _instantList;
  List<CommentEntity> get commentList => _commentList;
  InstantVO get instant => _instant;

  setIndex(int index) {
    _index = index;
  }

  /// 获取单个动态
  getInstant(InstantVO instant) {
    _instant = instant;
    // notifyListeners();
  }

  ///获取热门动态列表
  Future<bool> fetchHotInstantList() async {
    setBusy();
    var res = await FeedAPI.fetchHotInstant();
    _instantList = res.data;
    setIdle();
    return true;
  }

  /// 获取关注的人动态列表
  Future<bool> fetchFollowInstantList() async {
    setBusy();
    var res = await FeedAPI.fetchFollowInstant();
    _instantList = res.data;
    setIdle();
    return true;
  }

  /// 获取评论列表
  Future<bool> fetchCommentList() async {
    setBusy();
    var res = await FeedAPI.getCommentList(instantId: _instant.instant.id);
    _commentList = res.data;
    setIdle();
    return true;
  }

  /// 创建动态
  Future<bool> createInstant(
      {@required InstantEntity instant, String nickname, String avatar}) async {
    setBusy();
    try {
      var response = await FeedAPI.insertInstant(instant: instant);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
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

  /// 创建评论
  Future<bool> createComment(Comment comment) async {
    setIdle();
    await FeedAPI.insertComment(comment: comment);
    _instant.instant.commentNumber++;
    setIdle();
    return true;
  }

  /// 点赞动态
  Future<bool> likeInstant(int instantId) async {
    bool isLike = false;
    _instantList.forEach((element) {
      if (element.instant.id == instantId) {
        isLike = element.status == 0 ? false : true;
        if (element.status == 0) {
          element.instant.likeNumber++;
        } else {
          element.instant.likeNumber--;
        }
        element.status = element.status == 0 ? 1 : 0;
      }
    });

    FeedAPI.likeInstant({
      "instantId": instantId,
      "userId": int.parse(Global.accessToken),
    });
    notifyListeners();
    return true;
  }
}

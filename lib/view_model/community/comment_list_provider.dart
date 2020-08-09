import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class CommentListProvider extends ViewStateModel {
  List<CommentEntity> _commentList;
  int _instantId;

  int get instantId => _instantId;
  List<CommentEntity> get commentList => _commentList;

  CommentListProvider(int instantId) {
    _instantId = instantId;
    fetchCommentList(instantId);
  }

  /// 获取评论列表
  Future<bool> fetchCommentList(int instantId) async {
    setBusy();
    try {
      var response = await CommentAPI.getCommentList(instantId: instantId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _commentList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }

  /// 不需要参数获取评论列表
  Future<bool> fetchCommentListWithoutId() async {
    setBusy();
    try {
      var response = await CommentAPI.getCommentList(instantId: _instantId);
      if (response.error == true) {
        setError(null, null, message: response.errorMessage);
        return false;
      } else {
        _commentList = response.data;
        setIdle();
        return true;
      }
    } catch (e, s) {
      setError(e, s, message: "内部错误");
      return false;
    }
  }
}

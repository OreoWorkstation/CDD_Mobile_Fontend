import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/browse_entity.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class ArticleProvider extends ViewStateModel {
  List<ArticleResponseEntity> _recommendArticleList;
  List<ArticleResponseEntity> _hotArticleList;
  List<ArticleResponseEntity> _categoryArticleList;
  ArticleResponseEntity _article;

  List<ArticleResponseEntity> get recommendArticleList => _recommendArticleList;
  List<ArticleResponseEntity> get hotArticleList => _hotArticleList;
  List<ArticleResponseEntity> get categoryArticleList => _categoryArticleList;
  ArticleResponseEntity get article => _article;

  setArticle(ArticleResponseEntity article) {
    _article = article;
    notifyListeners();
  }

  Future<bool> fetchRecommend() async {
    setBusy();
    var res = await ArticleAPI.getRecommendArticleList(
        userId: int.parse(Global.accessToken));
    _recommendArticleList = res.data;
    setIdle();
    return true;
  }

  Future<bool> fetchHot() async {
    setBusy();
    var res = await ArticleAPI.getHotArticleList();
    _hotArticleList = res.data;
    setIdle();
    return true;
  }

  Future<bool> fetchCategory(int category) async {
    setBusy();
    var res = await ArticleAPI.getCategoryArticleList(category: category);
    _categoryArticleList = res.data;
    setIdle();
    return true;
  }

  postBrowse(int articleId, int starValue) async {
    int value = starValue + 2;
    if (_hotArticleList != null) {
      _hotArticleList.forEach((item) {
        if (item.id == articleId) item.browseValue = starValue;
      });
    }
    if (_recommendArticleList != null) {
      _recommendArticleList.forEach((item) {
        if (item.id == articleId) item.browseValue = starValue;
      });
    }
    await ArticleAPI.postBrowse(
      browse: BrowseEntity(
        articleId: articleId,
        userId: int.parse(Global.accessToken),
        browseValue: value,
      ),
    );
    notifyListeners();
  }
}

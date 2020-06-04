import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/provider/view_state_model.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/browse_entity.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';

class ArticleProvider extends ViewStateModel {
  List<ArticleResponseEntity> _recommendArticleList;
  List<ArticleResponseEntity> _hotArticleList;
  List<ArticleResponseEntity> _similarArticleList;
  List<ArticleResponseEntity> _categoryArticleList;
  ArticleResponseEntity _article;

  List<ArticleResponseEntity> get recommendArticleList => _recommendArticleList;
  List<ArticleResponseEntity> get hotArticleList => _hotArticleList;
  List<ArticleResponseEntity> get categoryArticleList => _categoryArticleList;
  List<ArticleResponseEntity> get similarArticleList => _similarArticleList;
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
    var res = await ArticleAPI.getHotArticleList(
        userId: int.parse(Global.accessToken));
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

  Future<bool> fetchSimilar(int articleId) async {
    setBusy();
    var res = await ArticleAPI.getSimilarArticleList(
        userId: int.parse(Global.accessToken), articleId: articleId);
    _similarArticleList = res.data;
    setIdle();
    return true;
  }

  postBrowse(int articleId, int starValue) async {
    print("文章ID: $articleId");
    print("传给provider的分数: $starValue");
    print("Token: ${Global.accessToken}");
    int value = starValue + 2;
    if (_hotArticleList != null) {
      _hotArticleList.forEach((item) {
        if (item.id == articleId) item.browseValue = value;
      });
    }
    if (_recommendArticleList != null) {
      _recommendArticleList.forEach((item) {
        if (item.id == articleId) item.browseValue = value;
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

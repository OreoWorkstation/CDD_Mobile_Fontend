import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/wiki/article_detail_page.dart';
import 'package:cdd_mobile_frontend/view/wiki/article_list_page.dart';
import 'package:cdd_mobile_frontend/view_model/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

List<String> categoryName = [
  "医疗",
  "饮食",
  "娱乐",
  "成长",
];

List<Color> categoryColor = [
  Color.fromARGB(255, 68, 217, 168),
  Color.fromARGB(255, 63, 100, 245),
  Color.fromARGB(255, 197, 109, 241),
  Color.fromARGB(255, 250, 59, 148),
];

class WikiPage extends StatefulWidget {
  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArticleProvider>(context, listen: false).fetchHot();
      Provider.of<ArticleProvider>(context, listen: false).fetchRecommend();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("community page build");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "百科",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: sHeight(20), left: sWidth(15), right: sWidth(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSwiper(),
            SizedBox(height: sHeight(10)),
            // Text(
            //   "分类",
            //   style: Theme.of(context).textTheme.title.copyWith(
            //         fontWeight: FontWeight.bold,
            //       ),
            // ),
            // _buildCategory(),
            Text(
              "推荐",
              style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: sHeight(10)),
            _buildRecommendList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSwiper() {
    return Consumer<ArticleProvider>(
      builder: (_, provider, __) {
        return provider.hotArticleList == null
            ? CircularProgressIndicator()
            : SizedBox(
                height: sHeight(200),
                child: Swiper(
                  onTap: (index) {},
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _buildSwiperItem(provider.hotArticleList[index]);
                  },
                  // scale: 0.6,
                  loop: true,
                  autoplay: true,
                  pagination: SwiperPagination(
                    margin: EdgeInsets.only(bottom: sHeight(20)),
                    builder: SwiperPagination.dots,
                  ),
                ),
              );
      },
    );
  }

  Widget _buildSwiperItem(ArticleResponseEntity article) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: Container(
            width: double.infinity,
            child: Image.network(
              article.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          borderRadius: Radii.k6pxRadius,
        ),
        GestureDetector(
          // TODO
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ArticleDetailPage(),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Radii.k6pxRadius,
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: sWidth(12),
                top: sHeight(17),
                right: sWidth(12),
              ),
              child: Text(
                article.content,
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white.withOpacity(.8),
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return SizedBox(
      height: sHeight(60),
      width: double.infinity,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _buildCategoryItem(0),
          _buildCategoryItem(0),
          _buildCategoryItem(0),
          _buildCategoryItem(0),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    return Container(
      // margin: EdgeInsets.only(
      //   right: sWidth(20),
      //   top: sHeight(10),
      //   bottom: sHeight(10),
      // ),
      width: sWidth(20),
      decoration: BoxDecoration(
        borderRadius: Radii.k10pxRadius,
        color: categoryColor[index],
      ),
      child: Center(
        child: Text(
          categoryName[index],
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRecommendList() {
    return Consumer<ArticleProvider>(
      builder: (_, provider, __) {
        if (provider.isBusy || provider.recommendArticleList == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (provider.recommendArticleList.isEmpty) {
          return Center(child: Text("No data"));
        }
        return Expanded(
          child: ArticleListPage(
            articleList: provider.recommendArticleList,
          ),
        );
      },
    );
  }
}

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/article_entity.dart';
import 'package:cdd_mobile_frontend/view/wiki/article_list_page.dart';
import 'package:cdd_mobile_frontend/view_model/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

List<String> testList = [
  "ssss",
  "sdfsdfsd",
  "sfdfsdf",
  "sdfsdf",
];
Color color = Color(0xff59c2ff);
final img =
    "https://images.unsplash.com/photo-1587733761351-c75905de4127?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=300&ixlib=rb-1.2.1&q=80&w=300";

class ArticleDetailPage extends StatefulWidget {
  final ArticleResponseEntity article;

  const ArticleDetailPage({Key key, this.article}) : super(key: key);
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  ArticleResponseEntity _article;
  int _starValue;
  bool _isLoadSimilar = false;

  @override
  void initState() {
    _article = widget.article;
    _starValue = cddGetStarValue(_article.browseValue).toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LoadingOverlay(
      color: Colors.transparent,
      isLoading: Provider.of<ArticleProvider>(context).isBusy,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0.6,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.dark,
            ),
            onPressed: () async {
              final provider =
                  Provider.of<ArticleProvider>(context, listen: false);
              await provider.postBrowse(_article.id, _starValue);
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "文章内容",
            style: TextStyle(color: AppColor.dark, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.zero,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sWidth(14), vertical: sHeight(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _article.title,
                        style: TextStyle(
                          fontSize: sSp(20),
                          color: Colors.black.withOpacity(.9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: sHeight(10)),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              new NetworkImage(_article.expertAvatar),
                        ),
                        title: Text(
                          _article.expertName,
                          style: TextStyle(
                            color: AppColor.dark,
                            fontSize: sSp(16),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          cddTimeLineFormat(_article.createTime),
                          style: TextStyle(
                            color: AppColor.grey,
                            fontSize: sSp(14),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: sHeight(10)),
                      Text(
                        _article.content,
                        style: TextStyle(
                          color: AppColor.dark,
                          height: 1.6,
                          fontSize: sSp(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Divider(
                        height: sHeight(40),
                        color: AppColor.grey.withOpacity(.6),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "这篇文章对您有帮助吗？",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: sSp(15),
                                color: AppColor.grey,
                              ),
                            ),
                            SizedBox(height: sHeight(10)),
                            CustomRating(
                              max: 5,
                              score: cddGetStarValue(_article.browseValue),
                              star: Star(
                                emptyColor: Colors.grey,
                                fillColor: Colors.redAccent,
                                fat: 0.7,
                              ),
                              onRating: (value) {
                                _starValue = value.toInt();
                                print("打分：$_starValue");
                              },
                            ),
                            SizedBox(height: sHeight(30)),
                            GestureDetector(
                              onTap: () async {
                                if (_isLoadSimilar == false) {
                                  var provider = Provider.of<ArticleProvider>(
                                      context,
                                      listen: false);
                                  await provider.fetchSimilar(_article.id);
                                  setState(() {
                                    _isLoadSimilar = true;
                                  });
                                }
                              },
                              child: Text(
                                "点击加载相似文章",
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: sSp(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(_buildSliverList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSliverList() {
    var provider = Provider.of<ArticleProvider>(context);

    if (!_isLoadSimilar) {
      return [];
    }
    List<ArticleResponseEntity> articleList = provider.similarArticleList;
    if (articleList == null) {
      return [];
    }
    List<Widget> widgetList = [];
    for (int i = 0; i < articleList.length; i++) {
      widgetList.add(_buildArticleListItem(articleList[i]));
    }
    return widgetList;
  }

  Widget _buildArticleListItem(ArticleResponseEntity article) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ArticleDetailPage(
            article: article,
          ),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: sHeight(17)),
        padding: EdgeInsets.symmetric(horizontal: sWidth(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: sWidth(200),
                  child: Text(
                    article.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: sSp(16),
                      color: AppColor.dark,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: sHeight(8)),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Container(
                      width: sWidth(22),
                      height: sWidth(22),
                      child: ClipOval(
                        child: Image.network(
                          article.expertAvatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: sWidth(5)),
                    Text(
                      article.expertName,
                      style: TextStyle(
                        color: AppColor.grey,
                        fontSize: sSp(14),
                      ),
                    ),
                    SizedBox(width: sWidth(5)),
                    Icon(
                      Icons.launch,
                      size: sSp(12),
                      color: AppColor.grey,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: sWidth(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  article.thumbnail,
                  width: sWidth(72),
                  height: sHeight(72),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ArticleDetailPage extends StatefulWidget {
//   final ArticleResponseEntity article;

//   const ArticleDetailPage({Key key, this.article}) : super(key: key);
//   @override
//   _ArticleDetailPageState createState() => _ArticleDetailPageState();
// }

// class _ArticleDetailPageState extends State<ArticleDetailPage> {
//   ArticleResponseEntity _article;
//   int _starValue;
//   bool _isLoadSimilar = false;

//   @override
//   void initState() {
//     _article = widget.article;
//     _starValue = cddGetStarValue(_article.browseValue).toInt();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     print("上次打分： ${cddGetStarValue(_article.browseValue)}");
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Positioned(
//             top: 0,
//             left: 0,
//             width: width,
//             height: height * .4,
//             child: Container(
//               decoration: BoxDecoration(
//                 /* borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(15),
//                   bottomRight: Radius.circular(15),
//                 ), */
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(_article.thumbnail),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             width: width,
//             height: height * .4,
//             child: Container(
//               decoration: BoxDecoration(
// /*                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//  */
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.black.withOpacity(.2),
//                     Colors.black.withOpacity(.6),
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             child: SafeArea(
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: Colors.white,
//                 ),
//                 onPressed: () async {
//                   print("退出页面时: $_starValue");
//                   final provider =
//                       Provider.of<ArticleProvider>(context, listen: false);
//                   await provider.postBrowse(_article.id, _starValue);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//           ),
//           Positioned(
//             top: height * .3 - sHeight(20),
//             left: 0,
//             width: width,
//             height: (height * .7) + sHeight(20),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     _article.title,
//                     style: TextStyle(
//                       fontSize: sSp(19),
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: sHeight(14)),
//                   Container(
//                     height: sHeight(3),
//                     width: width * .25,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: AppColor.primary,
//                     ),
//                   ),
//                   SizedBox(height: sHeight(30)),
//                   ListTile(
//                     contentPadding: EdgeInsets.only(left: 0),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       backgroundImage: new NetworkImage(_article.expertAvatar),
//                     ),
//                     title: Text(
//                       "${_article.expertName}",
//                       style: TextStyle(
//                         color: AppColor.dark,
//                         fontSize: sSp(16),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     subtitle: Text(
//                       cddTimeLineFormat(_article.createTime),
//                       style: TextStyle(
//                         color: AppColor.grey,
//                         fontSize: sSp(14),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             _article.content,
//                             textAlign: TextAlign.justify,
//                             style: TextStyle(
//                               fontSize: sSp(16),
//                               color: AppColor.dark,
//                               fontWeight: FontWeight.w400,
//                               height: 1.5,
//                             ),
//                           ),
//                           SizedBox(height: sHeight(30)),
//                           Text(
//                             "这篇文章对您有帮助吗？",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: sSp(14),
//                               color: AppColor.grey,
//                             ),
//                           ),
//                           SizedBox(height: sHeight(10)),
//                           CustomRating(
//                             max: 5,
//                             score: cddGetStarValue(_article.browseValue),
//                             star: Star(
//                               emptyColor: Colors.grey,
//                               fillColor: Colors.red,
//                               fat: 0.7,
//                             ),
//                             onRating: (value) {
//                               _starValue = value.toInt();
//                               print("打分：$_starValue");
//                             },
//                           ),
//                           SizedBox(height: sHeight(30)),
//                           GestureDetector(
//                             onTap: () {
//                               print("tap");
//                             },
//                             child: Text(
//                               "点击加载相似文章",
//                               style: TextStyle(
//                                 color: AppColor.primary,
//                                 fontSize: sSp(15),
//                               ),
//                             ),
//                           ),
//                           ListView.builder(
//                             itemBuilder: (context, index) {
//                               return Text("$index");
//                             },
//                             itemCount: 10,
//                           ),
//                           SizedBox(height: sHeight(30)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

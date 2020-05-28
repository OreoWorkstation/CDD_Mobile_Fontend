import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/article_entity.dart';
import 'package:cdd_mobile_frontend/view_model/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    _article = widget.article;
    _starValue = _article.browseValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(cddGetStarValue(_article.browseValue));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            width: width,
            height: height * .4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_article.thumbnail),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: width,
            height: height * .4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.2),
                    Colors.black.withOpacity(.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  print(_starValue);
                  final provider =
                      Provider.of<ArticleProvider>(context, listen: false);
                  provider.postBrowse(_article.id, _starValue);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: height * .3 - sHeight(20),
            left: 0,
            width: width,
            height: (height * .7) + sHeight(20),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _article.title,
                    style: TextStyle(
                      fontSize: sSp(20),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: sHeight(14)),
                  Container(
                    height: sHeight(5),
                    width: width * .25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color,
                    ),
                  ),
                  SizedBox(height: sHeight(30)),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: new NetworkImage(_article.expertAvatar),
                    ),
                    title: Text("by ${_article.expertName}"),
                    subtitle: Text(cddTimeLineFormat(_article.createTime)),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            _article.content,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.body2.copyWith(
                                  fontSize: sSp(14),
                                  height: 1.8,
                                ),
                          ),
                          SizedBox(height: sHeight(30)),
                          Text(
                            "这篇文章对您有帮助吗？",
                            style:
                                Theme.of(context).textTheme.subtitle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: sSp(14),
                                      color: Colors.black.withOpacity(.6),
                                    ),
                          ),
                          SizedBox(height: sHeight(10)),
                          CustomRating(
                            max: 5,
                            score: cddGetStarValue(_article.browseValue),
                            star: Star(
                              emptyColor: Colors.grey,
                              fillColor: Colors.red,
                              fat: 0.7,
                            ),
                            onRating: (value) {
                              _starValue = value.toInt();
                              print(_starValue);
                            },
                          ),
                          SizedBox(height: sHeight(30)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

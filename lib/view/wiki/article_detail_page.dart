import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/article_entity.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _article = widget.article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: height * .3,
            left: 0,
            width: width,
            height: (height * .7),
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
                  SizedBox(height: sHeight(20)),
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
                      child: Text(
                        _article.content,
                        textAlign: TextAlign.justify,
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

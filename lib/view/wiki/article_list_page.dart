import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/wiki/article_detail_page.dart';
import 'package:flutter/material.dart';

class ArticleListPage extends StatefulWidget {
  final List<ArticleResponseEntity> articleList;

  const ArticleListPage({Key key, this.articleList}) : super(key: key);
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  List<ArticleResponseEntity> _articleList;

  @override
  void initState() {
    super.initState();
    _articleList = widget.articleList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _articleList.length,
        itemBuilder: (context, index) {
          return _buildListItem(index);
        });
  }

  Widget _buildListItem(int index) {
    final article = _articleList[index];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ArticleDetailPage(),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: sHeight(72),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      // title
                      "Some important things",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: sSp(16),
                        color: Color(0xff325384),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Container(
                          width: sWidth(20),
                          height: sWidth(20),
                          child: ClipOval(
                            child: Image.network(
                              "https://images.unsplash.com/photo-1587733761351-c75905de4127?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=300&ixlib=rb-1.2.1&q=80&w=300",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: sWidth(5)),
                        Text(
                          // expertname
                          "Scott Wong",
                          style: TextStyle(
                            color: Color(0xff325384).withOpacity(.5),
                            fontSize: sSp(12),
                          ),
                        ),
                        SizedBox(width: sWidth(5)),
                        Icon(
                          Icons.launch,
                          size: sSp(12),
                          color: Color(0xff325384).withOpacity(.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: sWidth(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  "https://images.unsplash.com/photo-1589860711038-223912d9121c?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=300&ixlib=rb-1.2.1&q=80&w=300",
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

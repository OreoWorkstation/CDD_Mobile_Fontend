import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentListWidget extends StatefulWidget {
  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  List<InstantVO> _instantList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FeedProvider>(context, listen: false).fetchCommentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
      builder: (_, provider, __) => Builder(
        builder: (_) {
          if (provider.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.commentList == null) {
            return Center(child: CircularProgressIndicator());
          }
//          if (provider.commentList.isEmpty) {
//            return SizedBox.shrink();
//          }
          return ListView.builder(
            //itemCount: provider.commentList.length,
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildCommentRow(provider);
            },
          );
        },
      ),
    );
  }

  Widget _buildCommentRow(FeedProvider provider) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(
        left: sWidth(16),
        right: sWidth(8),
        top: sHeight(10),
        bottom: sHeight(10),
      ),
      margin: EdgeInsets.only(bottom: sHeight(10)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: sWidth(50),
                height: sWidth(50),
                child: ClipOval(
                  child: Image.network(
                    CAT_AVATAR,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: sWidth(17)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("David",
                  style: TextStyle(fontSize: sSp(16), color: Colors.black)),
              SizedBox(height: sHeight(5)),
              Text(
                "2020-05-21",
                style: TextStyle(
                    fontSize: sSp(14), color: Colors.black.withOpacity(.7)),
              ),
              SizedBox(height: sHeight(13)),
              Text(
                "sadfasdfasfdasdfasdfasd",
                style: TextStyle(fontSize: sSp(16), color: Colors.black),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: textBtnFlatButtonWidget(
                  onPressed: () {}, title: "Replay", fontSize: 14)),
        ],
      ),
    );
  }
}

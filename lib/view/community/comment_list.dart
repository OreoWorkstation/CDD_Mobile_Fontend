import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/user/user_zone.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentListWidget extends StatefulWidget {
  final instantId;

  const CommentListWidget({Key key, this.instantId}) : super(key: key);
  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FeedProvider>(context, listen: false).fetchCommentList();
    });
  }

  _handleComment(
    instantId, {
    bool isCommentOther = false,
    int parentId,
    String parentName,
  }) {
    print(isCommentOther);
    Navigator.push(
      context,
      PopRoute(
        child: InputBottomSheet(
          hintText: isCommentOther ? parentName : null,
          onEditingCompleteText: (text) async {
            UserInfoEntity _user =
                Provider.of<UserProvider>(context, listen: false).userInfo;
            print(_user.nickname);
            await Provider.of<FeedProvider>(context, listen: false)
                .createComment(
              Comment(
                id: 0,
                userId: _user.id,
                instantId: instantId,
                content: text,
                parentId: isCommentOther ? parentId : 0,
              ),
            );
            await Provider.of<FeedProvider>(context, listen: false)
                .fetchCommentList();
          },
        ),
      ),
    );
  }

  _routeToUserZone(int userId) async {
    await Provider.of<UserProvider>(context, listen: false)
        .fetchUserZone(userId);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UserZonePage(userId: userId),
      ),
    );
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
          if (provider.commentList.isEmpty) {
            // return SizedBox.shrink();
            return Center(
              child: Text(
                "写下你的评论吧！",
                style: TextStyle(
                  color: AppColor.lightGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: sSp(18),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: provider.commentList.length,
            itemBuilder: (context, index) {
              return _buildCommentRow(provider.commentList[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildCommentRow(CommentEntity comment) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () => _routeToUserZone(comment.userId),
            child: Container(
              width: sWidth(45),
              height: sWidth(45),
              child: ClipOval(
                child: Image.network(
                  comment.userAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: sWidth(16)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    comment.userNickname,
                    style: TextStyle(
                        fontSize: sSp(16),
                        color: AppColor.dark,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: sHeight(5)),
                  Text(
                    cddTimeLineFormat(comment.createTime),
                    style: TextStyle(fontSize: sSp(14), color: AppColor.grey),
                  ),
                  SizedBox(height: sHeight(5)),
                  comment.parentId == 0 || comment.parentId == null
                      ? Container(
                          width: sWidth(230),
                          child: Text(
                            comment.content,
                            style: TextStyle(
                                fontSize: sSp(16), color: Colors.black),
                            softWrap: true,
                          ),
                        )
                      : Container(
                          width: sWidth(230),
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "回复 ",
                                  style: TextStyle(
                                      fontSize: sSp(15), color: AppColor.grey),
                                ),
                                TextSpan(
                                  text: "${comment.parentNickname}",
                                  style: TextStyle(
                                      fontSize: sSp(16),
                                      color: AppColor.primary),
                                ),
                                TextSpan(
                                  text: ": ${comment.content}",
                                  style: TextStyle(
                                      fontSize: sSp(16),
                                      color: AppColor.dark,
                                      letterSpacing: 0.6,
                                      height: 1.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
          Spacer(),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.reply, color: AppColor.grey),
              onPressed: () => _handleComment(
                widget.instantId,
                isCommentOther: true,
                parentId: comment.userId,
                parentName: comment.userNickname,
              ),
            ),
          ),
          // textBtnFlatButtonWidget(
          //   onPressed: () => _handleComment(
          //     widget.instantId,
          //     isCommentOther: true,
          //     parentId: comment.userId,
          //     parentName: comment.userNickname,
          //   ),
          //   title: "回复",
          //   fontSize: sSp(14),
          //   textColor: Colors.black.withOpacity(.5),
          // ),
        ],
      ),
    );
  }
}

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/community/comment_list.dart';
import 'package:cdd_mobile_frontend/view/user/user_zone.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstantDetailPage extends StatefulWidget {
  // final InstantVO instantVO;

  //const InstantDetailPage({Key key, this.instantVO}) : super(key: key);
  @override
  _InstantDetailPageState createState() => _InstantDetailPageState();
}

class _InstantDetailPageState extends State<InstantDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  _handleLikeInstant(int instantId) async {
    Provider.of<FeedProvider>(context, listen: false).likeInstant(instantId);
  }

  _handleComment(
    instantId, {
    bool isCommentOther = false,
    int parentId,
    String parentName,
  }) {
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
    final provider = Provider.of<FeedProvider>(context);
    final _instantVO = provider.instant;
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "${_instantVO.nickname}",
              style:
                  TextStyle(color: AppColor.dark, fontWeight: FontWeight.w400),
            ),
            centerTitle: true,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0.6,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.dark),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: _buildBody(provider),
        ),
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: _buildInstantBottom(provider)),
      ],
    );
  }

  Widget _buildBody(FeedProvider provider) {
    return NestedScrollView(
      headerSliverBuilder: (context, _) {
        return [
          SliverToBoxAdapter(
            child: _buildInstantDetail(provider),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: sHeight(10)),
          ),
          SliverPersistentHeader(
            delegate: _myDelegate(provider),
            pinned: true,
          ),
        ];
      },
      body: CommentListWidget(instantId: provider.instant.instant.id),
    );
  }

  Widget _buildInstantDetail(provider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white70),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: sWidth(15), vertical: sHeight(10)),
        child: Column(
          children: <Widget>[
            _buildInstantHeader(provider),
            SizedBox(height: sHeight(12)),
            _buildInstantBody(provider),
            SizedBox(height: sHeight(12)),
            _buildInstantBottom(provider),
          ],
        ),
      ),
    );
  }

  // 动态头部: 头像, 昵称, 关注, 发布日期
  Widget _buildInstantHeader(FeedProvider provider) {
    final _instantVO = provider.instant;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              //onTap: () => _routeToUserZone(_instantVO.instant.userId),
              onTap: () => _routeToUserZone(_instantVO.instant.userId),
              child: Container(
                width: sWidth(45),
                height: sWidth(45),
                child: ClipOval(
                  child: Image.network(
                    _instantVO.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: sWidth(16)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _instantVO.nickname,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: sSp(16),
                      color: AppColor.dark),
                ),
                SizedBox(height: sHeight(5)),
                Text(
                  cddTimeLineFormat(_instantVO.instant.createTime),
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: sSp(14),
                  ),
                ),
              ],
            ),
          ],
        ),
        // _instantVO.instant.userId == int.parse(Global.accessToken)
        //     ? Container()
        //     : btnFlatButtonWidget(
        //         onPressed: () => _handleFollowButton(),
        //         width: 54,
        //         height: 25,
        //         title: "关注",
        //         fontSize: 11,
        //         bgColor: Color.fromARGB(255, 34, 232, 185),
        //       ),
      ],
    );
  }

  // 动态内容:图片,文字
  Widget _buildInstantBody(provider) {
    final _instantVO = provider.instant;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: sWidth(20), vertical: sHeight(10)),
          child: Text(
            _instantVO.instant.content,
            style: TextStyle(
              color: AppColor.dark,
              fontSize: sSp(16),
              letterSpacing: 0.6,
            ),
          ),
        ),
        _instantVO.instant.imagePath != ""
            ? SizedBox(height: sHeight(20))
            : SizedBox.shrink(),
        _instantVO.instant.imagePath == ""
            ? Container()
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SinglePhotoView(
                        imageProvider:
                            NetworkImage(_instantVO.instant.imagePath),
                        heroTag: 'simple',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: sWidth(350),
                  height: sHeight(400),
                  decoration: BoxDecoration(
                    borderRadius: Radii.k6pxRadius,
                    image: DecorationImage(
                      image: NetworkImage(_instantVO.instant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  // 动态底部: 点赞数,评论数
  Widget _buildInstantBottom(FeedProvider provider) {
    final _instantVO = provider.instant;
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => _handleLikeInstant(_instantVO.instant.id),
                //onPressed: (){},
                icon: _instantVO.status == 0
                    ? Icon(
                        Icons.favorite_border,
                        color: Colors.black38,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
              ),
              Text(
                "${_instantVO.instant.likeNumber}",
                style: TextStyle(fontSize: sSp(16), color: Colors.black38),
              ),
            ],
          ),
          SizedBox(width: sWidth(10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => _handleComment(_instantVO.instant.id),
                icon: Icon(
                  Iconfont.pinglun,
                  size: 25,
                ),
              ),
              Text(
                "${_instantVO.instant.commentNumber}",
                style: TextStyle(fontSize: sSp(16), color: Colors.black38),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _myDelegate extends SliverPersistentHeaderDelegate {
  final FeedProvider provider;

  _myDelegate(this.provider);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: sHeight(48),
      padding: EdgeInsets.symmetric(horizontal: sWidth(20)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text(
            "赞: ${provider.instant.instant.likeNumber}",
            style: TextStyle(fontSize: sSp(16), color: AppColor.dark),
          ),
          SizedBox(
            width: sWidth(15),
          ),
          Text(
            "评论: ${provider.instant.instant.commentNumber}",
            style: TextStyle(fontSize: sSp(16), color: AppColor.dark),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => sHeight(48);

  @override
  double get minExtent => sHeight(48);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/page/user/user_zone.dart';
import 'package:cdd_mobile_frontend/provider/community/comment_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class InstantDetailPage extends StatefulWidget {
  final InstantVO instantVO;
  InstantDetailPage({Key key, @required this.instantVO}) : super(key: key);

  @override
  _InstantDetailPageState createState() => _InstantDetailPageState();
}

class _InstantDetailPageState extends State<InstantDetailPage> {
  bool _isMe = false;

  InstantVO _instantVO;
  @override
  void initState() {
    super.initState();
    _instantVO = widget.instantVO;
    _isMe = _instantVO.instant.userId == int.parse(Global.accessToken);
  }

  _handleDeleteButton(context) {
    print("delete button");
  }

  // 关注该用户
  // _handleFollowButton() async {
  //   print("tap follow button");
  // }

  // 点赞
  // _handleLike() async {
  //   print("tap like button");
  // }

  // 跳转到用户空间
  _routeToUserZone(int userId) async {
    print("tap route to user zone");
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserZonePage(userId: userId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            title: Text("动态", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            actions: <Widget>[
              _isMe
                  ? IconButton(
                      onPressed: () => _handleDeleteButton(context),
                      icon: Icon(
                        Iconfont.shanchu,
                        color: Colors.red,
                        size: cddSetFontSize(25),
                      ),
                    )
                  : Container(),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            // expandedHeight:
            //     cddSetHeight(500) + MediaQuery.of(context).padding.top,
            // flexibleSpace: _buildInstant(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildInstant(),
            ]),
          ),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => CommentListProvider(_instantVO.instant.id),
              ),
            ],
            child: Consumer<CommentListProvider>(
              builder: (_, commentListProvider, __) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    _buildComment(commentListProvider),
                  ),
                );
              },
            ),
          ),

          // SliverList(delegate: SliverChildListDelegate([]),)
          // SliverList(),
        ],
      ),
    );
    */

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          "动态",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          _isMe
              ? IconButton(
                  onPressed: () => _handleDeleteButton(context),
                  icon: Icon(
                    Iconfont.shanchu,
                    color: Colors.red,
                    size: cddSetFontSize(25),
                  ),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: cddSetWidth(10),
            right: cddSetWidth(10),
            top: cddSetHeight(10)),
        child: Column(
          children: <Widget>[
            _buildInstant(),
            SizedBox(height: cddSetHeight(20)),
            _buildComment(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstant() {
    return Container(
      width: double.infinity,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: Radii.k10pxRadius,
      //   boxShadow: [
      //     BoxShadow(
      //       offset: Offset(0, 3),
      //       blurRadius: 6,
      //       color: Colors.grey,
      //     ),
      //   ],
      // ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: <Widget>[
            _buildInstantHeader(),
            SizedBox(height: cddSetHeight(12)),
            _buildInstantBody(),
            SizedBox(height: cddSetHeight(12)),
            // _buildInstantBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildComment() {
    return Column(
      children: <Widget>[],
    );
  }

  /*
  Widget _buildComment() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CommentListProvider(_instantVO.instant.id),
        ),
      ],
      child: Consumer<CommentListProvider>(
        builder: (_, commentListProvider, __) {
          if (commentListProvider == null || commentListProvider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          // if (commentListProvider.commentList.length == 0) {
          //   return Center(child: Text("no comment"));
          // }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: LoadingOverlay(
              isLoading: commentListProvider.isBusy,
              color: Colors.transparent,
              child: ListView.builder(
                // itemCount: commentListProvider.commentList.length,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: cddSetHeight(50),
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: cddSetHeight(10)),
                    color: Colors.blue,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
  */

  Widget _buildCommentRow(CommentEntity comment) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[],
      ),
    );
  }

  // 动态头部: 头像, 昵称, 关注, 发布日期
  Widget _buildInstantHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => _routeToUserZone(_instantVO.instant.userId),
              child: Container(
                width: cddSetWidth(50),
                height: cddSetWidth(50),
                child: ClipOval(
                  child: Image.network(
                    _instantVO.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: cddSetWidth(15)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _instantVO.nickname,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: cddSetFontSize(15),
                      color: Colors.black),
                ),
                SizedBox(height: cddSetHeight(5)),
                Text(
                  cddTimeLineFormat(_instantVO.instant.createTime),
                  style: TextStyle(
                    color: AppColor.secondaryTextColor,
                    fontSize: cddSetFontSize(13),
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
  Widget _buildInstantBody() {
    return Column(
      children: <Widget>[
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
                  width: cddSetWidth(300),
                  height: cddSetHeight(200),
                  decoration: BoxDecoration(
                    borderRadius: Radii.k10pxRadius,
                    image: DecorationImage(
                      image: NetworkImage(_instantVO.instant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        SizedBox(height: cddSetHeight(10)),
        Text(
          _instantVO.instant.content,
          style: TextStyle(
            color: Colors.black,
            fontSize: cddSetFontSize(16),
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }

  // 动态底部: 点赞数,评论数
  Widget _buildInstantBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     IconButton(
        //       onPressed: () => _handleLike(),
        //       icon: Icon(
        //         Iconfont.dianzan,
        //         size: 25,
        //       ),
        //     ),
        //     SizedBox(width: cddSetWidth(3)),
        //     Text(
        //       "${_instantVO.instant.likeNumber}",
        //       style: TextStyle(
        //           fontSize: cddSetFontSize(16),
        //           color: AppColor.secondaryElement),
        //     ),
        //   ],
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Iconfont.pinglun,
                size: 25,
              ),
            ),
            SizedBox(width: cddSetWidth(3)),
            Text(
              "${_instantVO.instant.commentNumber}",
              style: TextStyle(
                  fontSize: cddSetFontSize(16),
                  color: AppColor.secondaryElement),
            ),
          ],
        ),
      ],
    );
  }
}

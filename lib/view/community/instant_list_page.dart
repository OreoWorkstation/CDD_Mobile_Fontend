import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/community/instant_detail.dart';
import 'package:cdd_mobile_frontend/view/user/user_zone.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstantListPage extends StatefulWidget {
  final List<InstantVO> instantList;

  const InstantListPage({
    Key key,
    this.instantList,
  }) : super(key: key);

  @override
  _InstantListPageState createState() => _InstantListPageState();
}

class _InstantListPageState extends State<InstantListPage> {
  List<InstantVO> _instantList;

  @override
  void initState() {
    super.initState();
    _instantList = widget.instantList;
  }

  _handleLikeInstant(int instantId) async {
    Provider.of<FeedProvider>(context, listen: false).likeInstant(instantId);
  }

  _routeToDetailPage(InstantVO instantVO) async {
    Provider.of<FeedProvider>(context, listen: false).getInstant(instantVO);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => InstantDetailPage(),
    ));
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
    // return Padding(
    //   padding: EdgeInsets.only(
    //     left: sWidth(10),
    //     right: sWidth(10),
    //     top: sHeight(20),
    //   ),
    //   child: _buildBody(_instantList),
    // );
    return _buildBody(_instantList);
  }

  // 动态列表
  Widget _buildBody(List<InstantVO> instantList) {
    return ListView.builder(
      itemCount: instantList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildInstant(instantList[index]);
      },
    );
  }

  // 动态列表项
  Widget _buildInstant(InstantVO instantVO) {
    return GestureDetector(
      onTap: () => _routeToDetailPage(instantVO),
      child: Container(
        margin: EdgeInsets.only(bottom: sHeight(15)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: Colors.grey.withOpacity(.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 20, 17, 5),
          child: Column(
            children: <Widget>[
              _buildInstantHeader(instantVO),
              SizedBox(height: sWidth(12)),
              _buildInstantBody(instantVO),
              SizedBox(height: sWidth(12)),
              _buildInstantBottom(instantVO),
            ],
          ),
        ),
      ),
    );
  }

  // 动态头部: 头像, 昵称, 关注, 发布日期
  Widget _buildInstantHeader(InstantVO instantVO) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => _routeToUserZone(instantVO.instant.userId),
              child: Container(
                width: sWidth(45),
                height: sWidth(45),
                child: ClipOval(
                  child: Image.network(
                    instantVO.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: sWidth(15)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  instantVO.nickname,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: sSp(16),
                      color: AppColor.dark),
                ),
                SizedBox(height: sHeight(5)),
                Text(
                  cddTimeLineFormat(instantVO.instant.createTime),
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: sSp(14),
                  ),
                ),
              ],
            ),
          ],
        ),
        // instantVO.instant.userId == int.parse(Global.accessToken)
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
  Widget _buildInstantBody(InstantVO instantVO) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: sHeight(10)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sWidth(10)),
          child: GestureDetector(
            onTap: () => _routeToDetailPage(instantVO),
            //onTap: (){},
            child: Text(
              instantVO.instant.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(16),
                // letterSpacing: 0.6,
              ),
            ),
          ),
        ),
        instantVO.instant.imagePath != ""
            ? SizedBox(height: sHeight(20))
            : SizedBox.shrink(),
        instantVO.instant.imagePath == ""
            ? Container()
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SinglePhotoView(
                        imageProvider:
                            NetworkImage(instantVO.instant.imagePath),
                        heroTag: 'simple',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: sWidth(350),
                  height: sHeight(300),
                  decoration: BoxDecoration(
                    borderRadius: Radii.k6pxRadius,
                    image: DecorationImage(
                      image: NetworkImage(instantVO.instant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  // 动态底部: 点赞数,评论数
  Widget _buildInstantBottom(InstantVO instantVO) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => _handleLikeInstant(instantVO.instant.id),
              //onPressed: (){},
              icon: instantVO.status == 0
                  ? Icon(
                      Icons.favorite_border,
                      color: Colors.black38,
                    )
                  : Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
              // icon: Icon(
              //   Icons.thumb_up,
              //   color:
              //       instantVO.status == 0 ? Colors.black38 : Colors.redAccent,
              // ),
            ),
            Text(
              "${instantVO.instant.likeNumber}",
              style: TextStyle(fontSize: sSp(16), color: Colors.black38),
            ),
          ],
        ),
        SizedBox(width: sWidth(10)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => _routeToDetailPage(instantVO),
              // onPressed: () {},
              icon: Icon(
                Iconfont.pinglun,
                color: Colors.black38,
              ),
            ),
            Text(
              "${instantVO.instant.commentNumber}",
              style: TextStyle(fontSize: sSp(16), color: Colors.black38),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/page/community/instant_detail.dart';
import 'package:cdd_mobile_frontend/page/user/user_zone.dart';
import 'package:cdd_mobile_frontend/provider/community/instant_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityType extends StatefulWidget {
  final int type; // 0: 热门, 1: 关注
  CommunityType({Key key, @required this.type}) : super(key: key);

  @override
  _CommunityTypeState createState() => _CommunityTypeState();
}

class _CommunityTypeState extends State<CommunityType> {
  // 跳转到用户空间
  _routeToUserZone(int userId, BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserZonePage(userId: userId)),
    );
  }

  // 跳转到详细动态页
  _routeToDetailPage(InstantVO instantVO) async {
    print("tap route to detail page");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InstantDetailPage(
        instantVO: instantVO,
      ),
    ));
  }

  // 关注该用户
  _handleFollowButton() async {
    print("tap follow button");
  }

  // 点赞
  _handleLike() async {
    print("tap like button");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InstantListProvider>(
      builder: (_, instantListProvider, __) {
        if (instantListProvider == null || instantListProvider.isBusy) {
          return Center(child: CircularProgressIndicator());
        }
        if (instantListProvider.instantVOList0 == null ||
            instantListProvider.instantVOList1 == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (instantListProvider.instantVOList0.length == 0 ||
            instantListProvider.instantVOList1.length == 0) {
          if (widget.type == 1) {
            return Center(child: Text("你关注的人还没有发表任何动态哦!"));
          }
          return Center(child: Text("还没有人发表任何动态哦!"));
        }
        return Padding(
          padding: EdgeInsets.only(
            left: cddSetWidth(10),
            right: cddSetWidth(10),
            top: cddSetHeight(20),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: _buildBody(widget.type == 0
                      ? instantListProvider.instantVOList0
                      : instantListProvider.instantVOList1)),
            ],
          ),
        );
      },
    );
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
  Widget _buildInstant(InstantVO instantDTO) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: cddSetHeight(10),
        horizontal: cddSetWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Radii.k10pxRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 6,
            color: Colors.grey,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 20, 17, 5),
        child: Column(
          children: <Widget>[
            _buildInstantHeader(instantDTO),
            SizedBox(height: cddSetHeight(12)),
            _buildInstantBody(instantDTO),
            SizedBox(height: cddSetHeight(12)),
            // _buildInstantBottom(instantDTO),
          ],
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
              onTap: () => _routeToUserZone(instantVO.instant.userId, context),
              child: Container(
                width: cddSetWidth(45),
                height: cddSetWidth(45),
                child: ClipOval(
                  child: Image.network(
                    instantVO.avatar,
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
                  instantVO.nickname,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: cddSetFontSize(14),
                      color: Colors.black),
                ),
                SizedBox(height: cddSetHeight(5)),
                Text(
                  cddTimeLineFormat(instantVO.instant.createTime),
                  style: TextStyle(
                    color: AppColor.secondaryTextColor,
                    fontSize: cddSetFontSize(12),
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
      children: <Widget>[
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
                  width: cddSetWidth(280),
                  height: cddSetHeight(200),
                  decoration: BoxDecoration(
                    borderRadius: Radii.k10pxRadius,
                    image: DecorationImage(
                      image: NetworkImage(instantVO.instant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        SizedBox(height: cddSetHeight(10)),
        GestureDetector(
          onTap: () => _routeToDetailPage(instantVO),
          child: Text(
            instantVO.instant.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: cddSetFontSize(14),
              letterSpacing: 1.1,
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
        //       "${instantVO.instant.likeNumber}",
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
              onPressed: () => _routeToDetailPage(instantVO),
              icon: Icon(
                Iconfont.pinglun,
                size: 25,
              ),
            ),
            SizedBox(width: cddSetWidth(3)),
            Text(
              "${instantVO.instant.commentNumber}",
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

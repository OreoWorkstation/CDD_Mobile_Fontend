import 'dart:ui';

import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/page/community/instant_detail.dart';
import 'package:cdd_mobile_frontend/provider/user/user_zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserZonePage extends StatefulWidget {
  final userId;
  UserZonePage({Key key, @required this.userId}) : super(key: key);

  @override
  _UserZonePageState createState() => _UserZonePageState();
}

class _UserZonePageState extends State<UserZonePage> {
  _routeToDetailPage(InstantVO instantVO) async {
    print("tap route to detail page");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InstantDetailPage(
        instantVO: instantVO,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserZoneProvider(widget.userId),
        ),
      ],
      child: Consumer<UserZoneProvider>(
        builder: (_, userZoneProvider, __) {
          if (userZoneProvider == null || userZoneProvider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          var _userZone = userZoneProvider.userZone;
          print(_userZone.avatar);
          return Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: cddSetHeight(380.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_userZone.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Image.network(
                //   _userZone.avatar,
                //   fit: BoxFit.cover,
                // ),
              ),
              BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: new Container(
                  color: Colors.white.withOpacity(0.1),
                  width: MediaQuery.of(context).size.width,
                  height: cddSetHeight(400),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  brightness: Brightness.light,
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    SizedBox(
                      height: cddSetHeight(80),
                    ),
                    _buildHeader(_userZone),
                  ],
                ),
              ),
              _buildInstantList(_userZone.instantVOList),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(UserZoneEntity userZone) {
    return Padding(
      padding: EdgeInsets.only(left: cddSetWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                userZone.nickname,
                style: TextStyle(
                    fontSize: cddSetFontSize(25),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: cddSetWidth(38)),
              userZone.gender == 0
                  ? Icon(
                      Iconfont.nan2,
                      color: Colors.blue,
                      size: cddSetFontSize(24),
                    )
                  : Icon(Iconfont.nv3,
                      color: Colors.pink, size: cddSetFontSize(24)),
            ],
          ),
          SizedBox(height: cddSetHeight(19)),
          Text(
            userZone.introduction,
            style: TextStyle(
              color: Colors.white,
              fontSize: cddSetFontSize(15),
            ),
          ),
          SizedBox(height: cddSetHeight(13)),
          Row(
            children: <Widget>[
              Icon(Iconfont.ditu),
              SizedBox(width: cddSetWidth(16)),
              Text(
                userZone.address,
                style: TextStyle(
                    fontSize: cddSetFontSize(15), color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstantList(List<InstantVO> instantVOList) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: cddSetHeight(430),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(20),
          //   topRight: Radius.circular(20),
          // ),
        ),
        child: Container(
          child: ListView.builder(
              itemCount: instantVOList.length,
              itemBuilder: (context, index) {
                return _buildInstant(instantVOList[index]);
              }),
        ),
      ),
    );
  }

  Widget _buildInstant(InstantVO instantVO) {
    return Material(
      child: Container(
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
              _buildInstantHeader(instantVO),
              SizedBox(height: cddSetHeight(12)),
              _buildInstantBody(instantVO),
              SizedBox(height: cddSetHeight(12)),
              // _buildInstantBottom(instantVO),
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
            Container(
              width: cddSetWidth(45),
              height: cddSetWidth(45),
              child: ClipOval(
                child: Image.network(
                  instantVO.avatar,
                  fit: BoxFit.cover,
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

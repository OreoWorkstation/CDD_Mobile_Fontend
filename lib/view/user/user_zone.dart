import 'dart:ui';

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/community/instant_list_page.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserZonePage extends StatefulWidget {
  final userId;
  UserZonePage({Key key, @required this.userId}) : super(key: key);

  @override
  _UserZonePageState createState() => _UserZonePageState();
}

class _UserZonePageState extends State<UserZonePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUserZone(widget.userId);
    });
  }

  _handleFollow(UserProvider provider, bool isUnFollow) {
    provider.followUser(followedId: widget.userId, unFollow: isUnFollow);
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserInfoEntity userProfileInfo = userProvider.userProfileInfo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.6,
        centerTitle: true,
        title: Text(
          userProfileInfo.nickname,
          style: TextStyle(
            color: AppColor.dark,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.dark,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          userProvider.isLoggedUser
              ? SizedBox.shrink()
              : userProvider.isFollow == 1
                  ? textBtnFlatButtonWidget(
                      onPressed: () => _handleFollow(userProvider, true),
                      title: "取消关注",
                      fontSize: 15,
                      textColor: AppColor.grey,
                    )
                  : textBtnFlatButtonWidget(
                      onPressed: () => _handleFollow(userProvider, false),
                      title: "关注",
                      fontSize: 15,
                      textColor: AppColor.primary,
                    )
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverToBoxAdapter(
              child: _buildHeader(userProfileInfo),
            )
          ];
        },
        body: _buildSliverList(userProvider),
      ),
    );
  }

  Widget _buildHeader(UserInfoEntity user) {
    return Padding(
      padding: EdgeInsets.only(
          left: sWidth(20), top: sHeight(40), bottom: sHeight(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: sWidth(5)),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 0),
                  ),
                  child: CircleAvatar(
                    maxRadius: sWidth(60) / 2,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                ),
              ),
              SizedBox(width: sWidth(10)),
              Text(
                user.nickname,
                style: TextStyle(
                    fontSize: sSp(20),
                    fontWeight: FontWeight.w500,
                    color: AppColor.dark),
              ),
              SizedBox(width: sWidth(10)),
              user.gender == 0
                  ? Icon(
                      Iconfont.nan2,
                      color: Colors.blue,
                      size: sSp(20),
                    )
                  : Icon(
                      Iconfont.nv3,
                      color: Colors.pink,
                      size: sSp(20),
                    ),
            ],
          ),
          SizedBox(height: sHeight(14)),
          Text(
            user.introduction,
            style: TextStyle(
              color: AppColor.dark,
              fontSize: sSp(16),
            ),
          ),
          SizedBox(height: sHeight(13)),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, color: AppColor.primary.withOpacity(.8)),
              SizedBox(width: sWidth(10)),
              Text(
                user.address,
                style: TextStyle(fontSize: sSp(14), color: AppColor.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliverList(UserProvider userProvider) {
    return Builder(
      builder: (_) {
        if (userProvider.isBusy || userProvider.userZone == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (userProvider.userZone.instantVOList.isEmpty) {
          return Center(
              child: Text(
            "还没有发布动态哦",
            style: TextStyle(
              color: AppColor.lightGrey,
              fontSize: sSp(18),
              fontWeight: FontWeight.bold,
            ),
          ));
        }
        return Material(
          color: AppColor.background,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: InstantListPage(
                  instantList: userProvider.userZone.instantVOList)),
        );
      },
    );
  }
}

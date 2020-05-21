import 'dart:ui';

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/community/instant_list_page.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user/user_zone_provider.dart';
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
      // Provider.of<UserProvider>(context, listen: false)
      //     .fetchUserProfile(widget.userId);
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

    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: sHeight(300.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(userProfileInfo.avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: new Container(
            color: Colors.white.withOpacity(0.1),
            width: MediaQuery.of(context).size.width,
            height: sHeight(300),
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
            actions: <Widget>[
              userProvider.isLoggedUser
                  ? SizedBox.shrink()
                  : userProvider.isFollow == 1
                      ? textBtnFlatButtonWidget(
                          onPressed: () => _handleFollow(userProvider, true),
                          title: "取消关注",
                          fontSize: 15,
                          textColor: Colors.white,
                        )
                      : textBtnFlatButtonWidget(
                          onPressed: () => _handleFollow(userProvider, false),
                          title: "关注",
                          fontSize: 15,
                          textColor: Colors.white,
                        )
            ],
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: sHeight(60),
              ),
              _buildHeader(userProfileInfo),
            ],
          ),
        ),
        Positioned(
          top: sHeight(300),
          child: Builder(
            builder: (_) {
              if (userProvider.isBusy || userProvider.userZone == null) {
                return Center(child: CircularProgressIndicator());
              }
              if (userProvider.userZone.instantVOList.isEmpty) {
                return Center(child: Text("No instant"));
              }
              return Material(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: InstantListPage(
                        instantList: userProvider.userZone.instantVOList)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(UserInfoEntity user) {
    return Padding(
      padding: EdgeInsets.only(left: sWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                user.nickname,
                style: TextStyle(
                    fontSize: sSp(25),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: sWidth(20)),
              user.gender == 0
                  ? Icon(
                      Iconfont.nan2,
                      color: Colors.blue,
                      size: sSp(24),
                    )
                  : Icon(
                      Iconfont.nv3,
                      color: Colors.pink,
                      size: sSp(24),
                    ),
            ],
          ),
          SizedBox(height: sHeight(19)),
          Text(
            user.introduction,
            style: TextStyle(
              color: Colors.white,
              fontSize: sSp(15),
            ),
          ),
          SizedBox(height: sHeight(13)),
          Row(
            children: <Widget>[
              Icon(Iconfont.ditu),
              SizedBox(width: sWidth(16)),
              Text(
                user.address,
                style: TextStyle(fontSize: sSp(15), color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
class UserZonePage extends StatefulWidget {
  final userId;
  UserZonePage({Key key, this.userId}) : super(key: key);

  @override
  _UserZonePageState createState() => _UserZonePageState();
}

class _UserZonePageState extends State<UserZonePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUserProfile(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserInfoEntity userProfileInfo = userProvider.userProfileInfo;
    final FeedProvider feedProvider = Provider.of<FeedProvider>(context);
    return userProvider.isBusy || userProfileInfo == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverAppBar(
                    pinned: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    // title: Text(
                    //   userProfileInfo.nickname,
                    //   style: TextStyle(color: Colors.black),
                    // ),
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    brightness: Brightness.light,
                    expandedHeight: sHeight(350),
                    // flexibleSpace: FlexibleSpaceBar(
                    //   background: Image.network(
                    //     userProvider.userProfileInfo.avatar,
                    //     fit: BoxFit.cover,
                    //   ),
                    //   title: Text(
                    //     userProfileInfo.nickname,
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    //   centerTitle: true,
                    // ),
                    flexibleSpace: _buildHeader(userProfileInfo),
                  ),
                ];
              },
              body: Builder(
                builder: (_) {
                  if (feedProvider.isBusy || feedProvider.instantList == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (feedProvider.instantList.isEmpty) {
                    return Center(child: Text("No instant"));
                  }
                  return InstantListPage(instantList: feedProvider.instantList);
                },
              ),
            ),
          );
  }

  Widget _buildHeader(UserInfoEntity user) {
    return Stack(
      children: <Widget>[
        Image.network(
          user.avatar,
          height: sHeight(350),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: sHeight(350),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        //   child: Container(
        //     color: Colors.withOpacity(0.1),
        //     height: sHeight(350),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildHeaderText(UserInfoEntity user) {
    return Padding(
      padding: EdgeInsets.only(left: sWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                user.nickname,
                style: TextStyle(
                    fontSize: sSp(25),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: sWidth(38)),
              user.gender == 0
                  ? Icon(
                      Iconfont.nan2,
                      color: Colors.blue,
                      size: sSp(24),
                    )
                  : Icon(Iconfont.nv3, color: Colors.pink, size: sSp(24)),
            ],
          ),
          SizedBox(height: sHeight(19)),
          Text(
            user.introduction,
            style: TextStyle(
              color: Colors.white,
              fontSize: sSp(15),
            ),
          ),
          SizedBox(height: sHeight(13)),
          Row(
            children: <Widget>[
              Icon(Iconfont.ditu),
              SizedBox(width: sWidth(16)),
              Text(
                user.address,
                style: TextStyle(fontSize: sSp(15), color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

*/

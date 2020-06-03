import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/user/user_edit.dart';
import 'package:cdd_mobile_frontend/view/user/user_list_page.dart';
import 'package:cdd_mobile_frontend/view/user/user_zone.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  // 处理编辑用户信息
  // _handleEditUserInfo() async {
  //   await Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => UserEditPage(apiResponse: _apiResponse),
  //   ));
  // }

  // 处理退出登录按钮
  _handleLogout() {
    print("press log out button");
  }

  _routeToUserZone(int userId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UserZonePage(userId: userId),
      ),
    );
  }

  _routeToUserList(int type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UserListPage(type: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) => Builder(builder: (context) {
        if (provider.isBusy) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          color: AppColor.background,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                expandedHeight: 360,
                backgroundColor: AppColor.background,
                floating: true,
                pinned: false,
                flexibleSpace: _buildUserHeader(provider),
              ),
              SliverList(
                delegate: SliverChildListDelegate(_buildSliverList()),
              ),
            ],
          ),
        );
      }),
    );
  }

  // 用户界面头部
  _buildUserHeader(UserProvider provider) {
    final UserInfoEntity user = provider.userInfo;
    return ClipRRect(
      // borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.white,
            // gradient: LinearGradient(
            //   colors: [Color(0xFF4a00e0), Color(0xFF8e2de2)],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   height: sWidth(80),
            //   width: sWidth(80),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       image: NetworkImage(user.avatar),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            AnimatedContainer(
              duration: Duration(microseconds: 500),
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
                  maxRadius: sWidth(80) / 2,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ),
            ),
            SizedBox(height: sHeight(10)),
            Text(
              user.nickname,
              style: TextStyle(
                // color: AppColor.testTextBlackColor2,
                color: Colors.black,
                fontSize: sSp(16),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: sHeight(14)),
            Text(
              user.introduction,
              style: TextStyle(
                color: AppColor.dark,
                fontSize: sSp(14),
              ),
            ),
            SizedBox(height: sHeight(34)),
            _buildUserState(provider),
          ],
        ),
      ),
    );
  }

  // 用户界面Body
  List<Widget> _buildSliverList() {
    return [
      _buildSliverListItem(Icons.edit, "编辑个人资料", () {}),
      _buildSliverListItem(Icons.settings, "系统设置", () {}),
      _buildSliverListItem(Icons.help, "帮助", () {}),
      _buildSliverListItem(Icons.info_outline, "关于我们", () {}),
      _buildSliverListItem(Icons.exit_to_app, "注销登录", () {}),
      //_buildLogoutButton(),
    ];
  }

  // 用户界面头部：宠物，动态，关注，粉丝
  Widget _buildUserState(UserProvider provider) {
    final user = provider.userInfo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildUserStateItem("宠物", user.petNumber, () {}),
        _buildUserStateItem(
            "动态", user.instantNumber, () => _routeToUserZone(user.id)),
        _buildUserStateItem("关注", user.followNumber, () => _routeToUserList(0)),
        _buildUserStateItem("粉丝", user.fansNumber, () => _routeToUserList(1)),
      ],
    );
  }

  // 封装用户界面头部
  Widget _buildUserStateItem(String title, int value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(sWidth(10))),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 40,
                offset: Offset(0, 0),
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(
              sWidth(25), sHeight(15), sWidth(25), sHeight(15)),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: sSp(15),
                    color: AppColor.dark,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: sHeight(10),
              ),
              Text(
                "$value",
                style: TextStyle(
                    fontSize: sSp(14),
                    color: AppColor.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Body List Item
  Widget _buildSliverListItem(
      IconData prefixIcon, String title, VoidCallback onTap) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: sWidth(15), vertical: sHeight(6)),
      padding: EdgeInsets.symmetric(vertical: sHeight(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(sWidth(10))),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: sWidth(20)),
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(fontSize: sSp(16), color: AppColor.dark),
        ),
        leading: Icon(prefixIcon, color: AppColor.grey),
        trailing: Icon(Icons.navigate_next, color: AppColor.lightGrey),
      ),
    );
  }

  // 退出登录按钮
  _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: sWidth(77),
        right: sWidth(77),
        top: sHeight(20),
      ),
      child: primaryBtn(
        onPressed: _handleLogout,
        bgColor: AppColor.primaryElementRed,
        title: "退出登录",
      ),
    );
  }
}

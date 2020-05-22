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
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 360,
              backgroundColor: AppColor.primaryBackground,
              floating: true,
              pinned: false,
              flexibleSpace: _buildUserHeader(provider),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconfont.bianji1),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(_buildSliverList()),
            ),
          ],
        );
      }),
    );
  }

  // 用户界面头部
  _buildUserHeader(UserProvider provider) {
    final UserInfoEntity user = provider.userInfo;
    return ClipPath(
      clipper: UserBottomClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4a00e0).withOpacity(0.7),
          // gradient: LinearGradient(
          //   colors: [Color(0xFF4a00e0), Color(0xFF8e2de2)],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Container(
                width: sWidth(100),
                height: sWidth(100),
                child: Image.network(user.avatar, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: sHeight(10)),
            Text(
              user.nickname,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: sSp(17),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: sHeight(14)),
            Text(
              user.introduction,
              style: TextStyle(
                color: Colors.black,
                fontSize: sSp(15),
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
      _buildSliverListItem(Icons.settings, "系统设置", () {}),
      _buildSliverListItem(Icons.help, "帮助", () {}),
      _buildSliverListItem(Icons.info_outline, "关于我们", () {}),
      //_buildLogoutButton(),
    ];
  }

  // 用户界面头部：宠物，动态，关注，粉丝
  Widget _buildUserState(UserProvider provider) {
    final user = provider.userInfo;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sWidth(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildUserStateItem("宠物", user.petNumber, () {}),
          _buildUserStateItem(
              "动态", user.instantNumber, () => _routeToUserZone(user.id)),
          _buildUserStateItem(
              "关注", user.followNumber, () => _routeToUserList(0)),
          _buildUserStateItem("粉丝", user.fansNumber, () => _routeToUserList(1)),
        ],
      ),
    );
  }

  // 封装用户界面头部
  Widget _buildUserStateItem(String title, int value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            "$value",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Body List Item
  Widget _buildSliverListItem(
      IconData prefixIcon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title:
          Text(title, style: TextStyle(fontSize: sSp(18), color: Colors.black)),
      leading: Icon(prefixIcon, color: Colors.black),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
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

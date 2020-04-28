import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/page/user/user_edit.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  APIResponse<UserInfoEntity> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  _fetchUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await UserAPI.getUserInfo(int.parse(Global.accessToken));
    setState(() {
      _isLoading = false;
    });
  }

  // 处理编辑用户信息
  _handleEditUserInfo() async {
    print("press edit");
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserEditPage(apiResponse: _apiResponse),
    ));
    _fetchUserInfo();
  }

  // 处理退出登录按钮
  _handleLogout() {
    print("press log out button");
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 360,
                  backgroundColor: AppColor.primaryBackground,
                  floating: true,
                  pinned: false,
                  flexibleSpace: _buildUserHeader(),
                  actions: <Widget>[
                    IconButton(
                      onPressed: _handleEditUserInfo,
                      icon: Icon(Iconfont.bianji1),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(_buildSliverList()),
                ),
              ],
            ),
          );
  }

  // 用户界面头部
  _buildUserHeader() {
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
                width: cddSetWidth(100),
                height: cddSetWidth(100),
                child:
                    Image.network(_apiResponse.data.avatar, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: cddSetHeight(10)),
            Text(
              _apiResponse.data.nickname,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: cddSetFontSize(17),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: cddSetHeight(14)),
            Text(
              _apiResponse.data.introduction,
              style: TextStyle(
                color: Colors.black,
                fontSize: cddSetFontSize(15),
              ),
            ),
            SizedBox(height: cddSetHeight(34)),
            _buildUserState(),
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
      _buildLogoutButton(),
    ];
  }

  // 用户界面头部：宠物，动态，关注，粉丝
  Widget _buildUserState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cddSetWidth(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildUserStateItem("宠物", _apiResponse.data.petNumber, () {}),
          _buildUserStateItem("动态", _apiResponse.data.instantNumber, () {}),
          _buildUserStateItem("关注", _apiResponse.data.followNumber, () {}),
          _buildUserStateItem("粉丝", _apiResponse.data.fansNumber, () {}),
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
      title: Text(title,
          style: TextStyle(fontSize: cddSetFontSize(18), color: Colors.black)),
      leading: Icon(prefixIcon, color: Colors.black),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
    );
  }

  // 退出登录按钮
  _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: cddSetWidth(77),
        right: cddSetWidth(77),
        top: cddSetHeight(20),
      ),
      child: btnFlatButtonWidget(
        onPressed: _handleLogout,
        width: 221,
        height: 48,
        bgColor: AppColor.primaryElementRed,
        title: "退出登录",
        fontSize: 19,
      ),
    );
  }
}

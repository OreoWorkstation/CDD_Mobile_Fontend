import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/page/community/community.dart';
import 'package:cdd_mobile_frontend/page/home/home.dart';
import 'package:cdd_mobile_frontend/page/user/user.dart';
import 'package:cdd_mobile_frontend/page/wiki/wiki.dart';
import 'package:flutter/material.dart';

class ApplicationPage extends StatefulWidget {
  ApplicationPage({Key key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  // 当前 tab 页码
  int _currentIndex = 0;

  // 页控制器
  PageController _pageController;

  // 底部导航项目
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Iconfont.shouye), title: Text("首页")),
    BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("百科")),
    BottomNavigationBarItem(icon: Icon(Iconfont.shequ), title: Text("社区")),
    BottomNavigationBarItem(
        icon: Icon(Iconfont.gerenzhongxin), title: Text("个人中心")),
  ];

  /*
  // tab栏动画
  void _handleNavBarTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(microseconds: 200), curve: Curves.ease);
  }
  */

  // tab栏页码切换
  void _handlePageChanged(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  // 内容页
  Widget _buildPageView() {
    return IndexedStack(
      index: this._currentIndex,
      children: <Widget>[
        HomePage(),
        WikiPage(),
        CommunityPage(),
        UserPage(),
      ],
    );
  }

  // 底部导航
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _bottomTabs,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.primaryBackground,
      elevation: 0,
      onTap: _handlePageChanged,
      selectedItemColor: AppColor.tabElementActive,
      // unselectedItemColor: AppColor.tabElementInactive,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: this._currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

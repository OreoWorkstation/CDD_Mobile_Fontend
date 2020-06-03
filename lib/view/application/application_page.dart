import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/view/community/community_page.dart';
import 'package:cdd_mobile_frontend/view/home/home_page.dart';
import 'package:cdd_mobile_frontend/view/user/user_page.dart';
import 'package:cdd_mobile_frontend/view/wiki/wiki_page.dart';
import 'package:cdd_mobile_frontend/view_model/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  List<Widget> _pageList;

  final _pageController = PageController();

  ApplicationProvider provider = ApplicationProvider();

  List<BottomNavigationBarItem> _list;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    _pageList = [
      HomePage(),
      WikiPage(),
      CommunityPage(),
      UserPage(),
    ];
  }

  // 底部导航项目
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    // BottomNavigationBarItem(
    //     icon: Icon(Iconfont.shouye),
    //     title: Padding(
    //       padding: EdgeInsets.only(top: sHeight(1)),
    //       child: Text("首页"),
    //       key: Key("home"),
    //     )),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.local_library),
    //     title: Padding(
    //       padding: EdgeInsets.only(top: sHeight(1)),
    //       child: Text("百科"),
    //       key: Key("wiki"),
    //     )),
    // BottomNavigationBarItem(
    //     icon: Icon(Iconfont.shequ),
    //     title: Padding(
    //       padding: EdgeInsets.only(top: sHeight(1)),
    //       child: Text("社区"),
    //       key: Key("community"),
    //     )),
    // BottomNavigationBarItem(
    //     icon: Icon(Iconfont.gerenzhongxin),
    //     title: Padding(
    //       padding: EdgeInsets.only(top: sHeight(1)),
    //       child: Text("个人中心"),
    //       key: Key("profile"),
    //     )),
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: sHeight(8)),
          child: Icon(Icons.home),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: sHeight(2)),
          child: Text("首页"),
          key: Key("home"),
        )),
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: sHeight(8)),
          child: Icon(Icons.layers),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: sHeight(2)),
          child: Text("百科"),
          key: Key("wiki"),
        )),
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Icon(Icons.whatshot),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: sHeight(2)),
          child: Text("社区"),
          key: Key("community"),
        )),
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Icon(Icons.person),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: sHeight(2)),
          child: Text("我的"),
          key: Key("profile"),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => provider,
      child: Scaffold(
        bottomNavigationBar: Consumer<ApplicationProvider>(
          builder: (_, provider, __) {
            return ClipRRect(
              // borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              child: BottomNavigationBar(
                items: _bottomTabs,
                currentIndex: provider.value,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                // elevation: 0,
                onTap: (index) => _pageController.jumpToPage(index),
                // selectedItemColor: AppColor.tabElementActive,
                selectedItemColor: AppColor.testBlueColor1,
                unselectedItemColor: Colors.black45,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: TextStyle(fontSize: sSp(12)),
                unselectedLabelStyle: TextStyle(fontSize: sSp(12)),
              ),
            );
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pageList,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    provider.value = index;
  }
}

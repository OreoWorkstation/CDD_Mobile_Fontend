import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/page/community/community_type.dart';
import 'package:cdd_mobile_frontend/page/community/instant_add.dart';
import 'package:cdd_mobile_frontend/provider/community/instant_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InstantListProvider(),
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(cddSetHeight(55)),
          child: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 1,
            automaticallyImplyLeading: false,
            bottom: _buildTabBar(),
          ),
        ),
        body: _buildTabView(context),
        floatingActionButton: Consumer<InstantListProvider>(
          builder: (_, instantListProvider, __) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: AppColor.primaryElement.withOpacity(0.8),
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InstantAddPage(),
                ));
                instantListProvider.fetchAllData();
              },
            );
          },
        ),
      ),
    );
  }

  // 顶部tab布局
  Widget _buildTabBar() {
    return TabBar(
      isScrollable: false,
      controller: _tabController,
      labelPadding: EdgeInsets.only(bottom: cddSetHeight(5)),
      labelStyle:
          TextStyle(fontSize: cddSetFontSize(18), fontWeight: FontWeight.bold),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black45,
      indicatorColor: Colors.transparent,
      tabs: <Widget>[Text("热门"), Text("关注")],
    );
  }

  // 主界面布局
  Widget _buildTabView(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        CommunityType(type: 0),
        CommunityType(type: 1),
      ],
    );
  }
}

/*
class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Padding(
        padding: EdgeInsets.only(
          left: cddSetWidth(10),
          right: cddSetWidth(10),
          top: cddSetHeight(20),
        ),
        child: Column(
          children: <Widget>[
            _buildHeader(),
            Divider(
              height: cddSetHeight(40),
            ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cddSetWidth(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "推荐",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: cddSetFontSize(20)),
          ),
          Text(
            "关注",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: cddSetFontSize(20)),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        _buildInstant(),
        _buildInstant(),
      ],
    );
  }

  Widget _buildInstant() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: cddSetHeight(10),
        horizontal: cddSetWidth(5),
      ),
      width: double.infinity,
      // height: cddSetHeight(300),
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
            _buildInstantHeader(),
            SizedBox(height: cddSetHeight(12)),
            _buildInstantBody(),
            SizedBox(height: cddSetHeight(12)),
            _buildInstantBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstantHeader() {
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
                  "https://images.unsplash.com/photo-1485206412256-701ccc5b93ca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=812&q=80",
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
                  "Alan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: cddSetFontSize(14),
                      color: Colors.black),
                ),
                SizedBox(height: cddSetHeight(5)),
                Text(
                  "2020-04-01 10:00",
                  style: TextStyle(
                    color: AppColor.secondaryTextColor,
                    fontSize: cddSetFontSize(12),
                  ),
                ),
              ],
            ),
          ],
        ),
        btnFlatButtonWidget(
          onPressed: () {},
          width: 54,
          height: 25,
          title: "关注",
          fontSize: 11,
          bgColor: Color.fromARGB(255, 34, 232, 185),
        ),
      ],
    );
  }

  Widget _buildInstantBody() {
    return Text(
      "前线毛油被内员之百面须，军商越区发被和强放表，无消A品板虚吼义声。 型关度时断角因对，保所了状各想公第，厂6鹰压任边。 定如所速为情做南，近业最刷除政。",
      style: TextStyle(
        color: Colors.black,
        fontSize: cddSetFontSize(14),
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildInstantBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Iconfont.dianzan,
                size: 25,
              ),
            ),
            SizedBox(width: cddSetWidth(3)),
            Text(
              "10",
              style: TextStyle(
                  fontSize: cddSetFontSize(16),
                  color: AppColor.secondaryElement),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Iconfont.pinglun,
                size: 25,
              ),
            ),
            SizedBox(width: cddSetWidth(3)),
            Text(
              "10",
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
*/

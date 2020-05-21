import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/view/community/follow_instant_page.dart';
import 'package:cdd_mobile_frontend/view/community/hot_instant_page.dart';
import 'package:cdd_mobile_frontend/view/community/instant_add_page.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with AutomaticKeepAliveClientMixin {
  List<String> tabs = ['热门', '关注'];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("community page build");
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          title: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black26,
            unselectedLabelStyle: TextStyle(
              fontSize: sSp(17),
            ),
            labelStyle: TextStyle(
              fontSize: sSp(18),
              fontWeight: FontWeight.bold,
            ),
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: List.generate(
                tabs.length,
                (index) => Tab(
                      text: tabs[index],
                    )),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HotInstantPage(),
            FollowInstantPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InstantAddPage(),
            ));
            int _index =
                DefaultTabController.of(_scaffoldKey.currentContext).index;
            if (_index == 0) {
              Provider.of<FeedProvider>(context, listen: false)
                  .fetchHotInstantList();
            } else {
              Provider.of<FeedProvider>(context, listen: false)
                  .fetchHotInstantList();
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

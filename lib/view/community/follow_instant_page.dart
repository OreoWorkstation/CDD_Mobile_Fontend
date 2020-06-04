import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/community/instant_list_page.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowInstantPage extends StatefulWidget {
  @override
  _FollowInstantPageState createState() => _FollowInstantPageState();
}

class _FollowInstantPageState extends State<FollowInstantPage> {
  List<InstantVO> _instantList;
  @override
  void initState() {
    super.initState();
    print("Hot instant page init");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedProvider>(context, listen: false)
          .fetchFollowInstantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
      builder: (_, provider, __) => Builder(builder: (_) {
        if (provider.isBusy || provider.instantList == null) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (provider.instantList.isEmpty) {
          return Center(
            child: Text("你关注的人还没有发布动态哦"),
          );
        }
//          return Expanded(
//            child: InstantListPage(instantList: provider.instantList),
//          );
        return InstantListPage(
          instantList: provider.instantList,
        );
      }),
    );
  }
}

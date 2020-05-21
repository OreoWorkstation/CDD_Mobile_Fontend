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
      Provider.of<FeedProvider>(context, listen: false).fetchHotInstantList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
      builder: (_, provider, __) => Builder(builder: (_) {
        if (provider.isBusy) {
          return CddLoadingWidget();
        }
        if (provider.instantList == null || provider.instantList.isEmpty) {
          return CddLoadingWidget();
        }
//          return Expanded(
//            child: InstantListPage(instantList: provider.instantList),
//          );
        return InstantListPage(instantList: provider.instantList,);
      }),
    );
  }
}

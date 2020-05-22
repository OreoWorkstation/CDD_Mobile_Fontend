import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/color.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/user/user_zone.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatefulWidget {
  final int type;

  const UserListPage({Key key, this.type}) : super(key: key);
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchFollowList();
      Provider.of<UserProvider>(context, listen: false).fetchFansList();
    });
  }

  _routeToUserZone(int userId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UserZonePage(userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: widget.type == 0 ? Text("关注列表") : Text("粉丝列表"),
        centerTitle: true,
        backgroundColor: Colours.app_main,
      ),
      body: Builder(
        builder: (_) {
          if (provider.isBusy ||
              provider.followList == null ||
              provider.fansList == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.followList.isEmpty || provider.fansList.isEmpty) {
            return Center(
                child: widget.type == 0
                    ? Text("暂时还没有关注任何人哦！")
                    : Text("暂时还没有被其他人关注过哦！"));
          }
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sWidth(5), vertical: sHeight(20)),
            child: ListView.builder(
                itemCount: widget.type == 0
                    ? provider.followList.length
                    : provider.fansList.length,
                itemBuilder: (context, index) {
                  return _buildListItem(provider, index);
                }),
          );
        },
      ),
    );
  }

  Widget _buildListItem(UserProvider provider, int index) {
    final list = widget.type == 0 ? provider.followList : provider.fansList;
    final FollowReponseEntity user = list[index];
    return InkWell(
      onTap: () => _routeToUserZone(user.userId),
      child: Container(
        margin: EdgeInsets.only(bottom: sHeight(20)),
        child: ListTile(
          leading: Container(
            height: sWidth(50),
            width: sWidth(50),
            child: ClipOval(
              child: Image.network(
                user.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(user.nickname),
          subtitle: Text(user.introduction),
        ),
      ),
    );
  }
}

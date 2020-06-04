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

  _routeToUserZone(int userId) async {
    await Provider.of<UserProvider>(context, listen: false)
        .fetchUserZone(userId);
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
        title: widget.type == 0
            ? Text(
                "关注列表",
                style: TextStyle(
                    color: AppColor.dark, fontWeight: FontWeight.w400),
              )
            : Text(
                "粉丝列表",
                style: TextStyle(
                    color: AppColor.dark, fontWeight: FontWeight.w400),
              ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.6,
        brightness: Brightness.light,
        leading: IconButton(
          color: AppColor.dark,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Builder(
        builder: (_) {
          if (provider.isBusy ||
              provider.followList == null ||
              provider.fansList == null) {
            return Center(child: CircularProgressIndicator());
          }
          if ((widget.type == 0 && provider.followList.isEmpty) ||
              (widget.type == 1 && provider.fansList.isEmpty)) {
            return Center(
              child: widget.type == 0
                  ? Text(
                      "暂时还没有关注任何人哦！",
                      style: TextStyle(
                        color: AppColor.lightGrey,
                        fontSize: sSp(18),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      "暂时还没有被其他人关注过哦！",
                      style: TextStyle(
                        color: AppColor.lightGrey,
                        fontSize: sSp(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sWidth(10), vertical: sHeight(10)),
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
        margin: EdgeInsets.only(bottom: sHeight(10)),
        padding:
            EdgeInsets.symmetric(vertical: sHeight(10), horizontal: sWidth(2)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
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
          title: Text(
            user.nickname,
            style: TextStyle(
                color: AppColor.dark,
                fontWeight: FontWeight.w500,
                fontSize: sSp(16)),
          ),
          subtitle: Text(
            user.introduction,
            style: TextStyle(
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
                fontSize: sSp(14)),
          ),
        ),
      ),
    );
  }
}

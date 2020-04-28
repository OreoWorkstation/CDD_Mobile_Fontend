import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';

class UserEditPage extends StatefulWidget {
  final apiResponse;
  UserEditPage({Key key, @required this.apiResponse}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  APIResponse<UserInfoEntity> _apiResponse;

  @override
  void initState() {
    _apiResponse = widget.apiResponse;
    super.initState();
  }

  // 处理返回按钮
  _handleBackButton() {
    Navigator.of(context).pop();
  }

  // 处理保存用户信息按钮
  _handleSaveUserInfoButton() {
    print("press save button");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackground,
        title: Text("编辑", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        brightness: Brightness.light,
        elevation: 0.0,
        leading: IconButton(
          onPressed: _handleBackButton,
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          textBtnFlatButtonWidget(
              onPressed: _handleSaveUserInfoButton, title: "保存"),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: cddSetWidth(33)),
        child: Column(
          children: <Widget>[
            _buildListItem(
              "头像",
              GestureDetector(
                onTap: () {
                  print("Tap avatar");
                },
                child: Container(
                  width: cddSetWidth(67),
                  height: cddSetWidth(67),
                  child: ClipOval(
                    child: Image.network(
                      _apiResponse.data.avatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String title, Widget operation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: cddSetFontSize(17),
            color: AppColor.secondaryTextColor.withOpacity(0.6),
          ),
        ),
        operation,
      ],
    );
  }
}

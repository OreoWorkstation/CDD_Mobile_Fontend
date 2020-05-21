import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/choose_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEditPage extends StatefulWidget {
  final apiResponse;
  UserEditPage({Key key, @required this.apiResponse}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  APIResponse<UserInfoEntity> _apiResponse;

  String _avatar;
  TextEditingController _nicknameController = TextEditingController();
  int _gender;
  TextEditingController _introductionController = TextEditingController();

  @override
  void initState() {
    _apiResponse = widget.apiResponse;
    super.initState();
    _avatar = _apiResponse.data.avatar;
    _nicknameController.text = _apiResponse.data.nickname;
    _gender = _apiResponse.data.gender;
    _introductionController.text = _apiResponse.data.introduction;
  }

  // 处理返回按钮
  _handleBackButton(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 处理保存用户信息按钮
  _handleSaveUserInfoButton() {
    print("press save button");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChooseImageProvider(_avatar),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryBackground,
          title: Text("编辑", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          brightness: Brightness.light,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => _handleBackButton(context),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: <Widget>[
            textBtnFlatButtonWidget(
                onPressed: _handleSaveUserInfoButton, title: "保存"),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: sWidth(33)),
          child: Column(
            children: <Widget>[
              _buildListItem(
                "头像",
                GestureDetector(
                  onTap: () {
                    print("Tap avatar");
                  },
                  child: Container(
                    width: sWidth(67),
                    height: sWidth(67),
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
              buildFormListItem(
                title: "昵称",
                operation: TextField(
                  controller: _nicknameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: sSp(18),
                    color: AppColor.primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
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
            fontSize: sSp(17),
            color: AppColor.secondaryTextColor.withOpacity(0.6),
          ),
        ),
        operation,
      ],
    );
  }
}

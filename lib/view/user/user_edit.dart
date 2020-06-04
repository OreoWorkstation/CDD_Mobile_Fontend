import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/choose_image_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class UserEditPage extends StatefulWidget {
  UserEditPage({Key key}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  String _avatar;
  TextEditingController _nicknameController = TextEditingController();
  int _gender;
  TextEditingController _introductionController = TextEditingController();
  String _address;

  @override
  void initState() {
    super.initState();
    UserInfoEntity _user =
        Provider.of<UserProvider>(context, listen: false).userInfo;
    _avatar = _user.avatar;
    _nicknameController.text = _user.nickname;
    _gender = _user.gender;
    _introductionController.text = _user.introduction;
    _address = _user.address;
  }

  // 处理返回按钮
  _handleBackButton(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 处理保存用户信息按钮
  _handleSaveUserInfoButton() {
    print(_avatar);
    print(_nicknameController.text);
    print(_introductionController.text);
    print(_gender);
    print(_address);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserInfoEntity user = userProvider.userInfo;
    return ChangeNotifierProvider(
      create: (_) => ChooseImageProvider(_avatar),
      child: Consumer<ChooseImageProvider>(
        builder: (_, chooseImageProvider, __) {
          _avatar = chooseImageProvider.imageNetworkPath;
          return LoadingOverlay(
            color: Colors.transparent,
            isLoading: chooseImageProvider.isBusy,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("编辑个人信息",
                    style: TextStyle(
                        color: AppColor.dark, fontWeight: FontWeight.w400)),
                centerTitle: true,
                brightness: Brightness.light,
                elevation: 0.6,
                leading: IconButton(
                  onPressed: () => _handleBackButton(context),
                  icon: Icon(Icons.arrow_back, color: AppColor.dark),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.done,
                      color: AppColor.dark,
                    ),
                    onPressed: () => _handleSaveUserInfoButton(),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sWidth(20), vertical: sHeight(10)),
                child: Column(
                  children: <Widget>[
                    _buildListItem(
                      "头像",
                      GestureDetector(
                        onTap: () {
                          // 更改头像弹框
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => LoadingOverlay(
                              isLoading: chooseImageProvider.isBusy,
                              color: Colors.transparent,
                              child: choosePhotoBottomSheetWidget(
                                context: context,
                                tapCamera: () async {
                                  await chooseImageProvider
                                      .getImageFromCamera();
                                  Navigator.of(context).pop();
                                },
                                tapGallery: () async {
                                  await chooseImageProvider
                                      .getImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: sWidth(50),
                          height: sWidth(50),
                          child: ClipOval(
                            child: Image.network(
                              _avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sHeight(15)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: sHeight(5), horizontal: sWidth(10)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: buildFormListItem(
                        title: "昵称",
                        operation: TextField(
                          controller: _nicknameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                          ),
                          maxLength: 10,
                          style: TextStyle(
                            fontSize: sSp(18),
                            color: AppColor.dark,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sHeight(15)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: sHeight(5), horizontal: sWidth(10)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildIntro(),
                    ),
                    SizedBox(height: sHeight(15)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: sHeight(5), horizontal: sWidth(10)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildGender(),
                    ),
                    SizedBox(height: sHeight(15)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: sHeight(15), horizontal: sWidth(10)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildCityPicker(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIntro() {
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Positioned(
          top: sHeight(10),
          child: Text(
            "个人介绍",
            style: TextStyle(
              color: AppColor.dark.withOpacity(.7),
              fontSize: sSp(16),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: sWidth(200),
            child: TextField(
              controller: _introductionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
              ),
              maxLength: 41,
              maxLines: null,
              style: TextStyle(
                fontSize: sSp(16),
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        // operation,
      ],
    );
  }

  Widget _buildGender() {
    return buildFormListItem(
      title: "性别",
      operation: Row(
        children: <Widget>[
          Flexible(
            child: RadioListTile(
              value: 0,
              title: Text(
                "男",
                style: TextStyle(
                  color: AppColor.dark,
                  fontSize: sSp(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ),
          Flexible(
            child: RadioListTile(
              value: 1,
              title: Text(
                "女",
                style: TextStyle(
                  color: AppColor.dark,
                  fontSize: sSp(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityPicker() {
    return buildFormListItem(
      title: "住址",
      operation: GestureDetector(
        onTap: () async {
          Result result1 = await CityPickers.showCityPicker(
            context: context,
            height: sHeight(220),
            cancelWidget: Text(
              "取消",
              style: TextStyle(
                color: AppColor.grey,
                fontSize: sSp(16),
                fontWeight: FontWeight.w500,
              ),
            ),
            confirmWidget: Text(
              "完成",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: sSp(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          );
          setState(() {
            if (result1 != null) {
              _address = result1.provinceName + "-" + result1.cityName;
            }
          });
          print(_address);
        },
        child: Text(
          _address,
          style: TextStyle(
            color: AppColor.dark,
            fontSize: sSp(16),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, Widget operation) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: sHeight(8), horizontal: sWidth(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: sSp(16),
              color: AppColor.dark.withOpacity(0.7),
            ),
          ),
          operation,
        ],
      ),
    );
  }
}

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/provider/choose_avatar_provider.dart';
import 'package:cdd_mobile_frontend/provider/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class PetAddSecondPage extends StatefulWidget {
  const PetAddSecondPage({Key key, @required this.species}) : super(key: key);
  final String species;

  @override
  _PetAddSecondPageState createState() => _PetAddSecondPageState();
}

class _PetAddSecondPageState extends State<PetAddSecondPage> {
  // 宠物昵称控制器
  TextEditingController _nicknameController = TextEditingController();
  // 宠物介绍控制器
  TextEditingController _introductionController = TextEditingController();
  // 宠物生日，默认为当前时间
  DateTime _birthday = DateTime.now();
  // 宠物性别，默认为男
  int _gender = 0;
  // 宠物默认头像
  String _defaultAvatar = "";

  @override
  void initState() {
    super.initState();
    _defaultAvatar = widget.species == "cat" ? CAT_AVATAR : DOG_AVATAR;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChooseAvatarProvider(_defaultAvatar),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text(
            "添加宠物",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: <Widget>[
            _buildFinishButton(context),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: cddSetWidth(40),
              right: cddSetWidth(40),
              top: cddSetHeight(40),
            ),
            child: Column(
              children: <Widget>[
                _buildAvatar(context),
                Divider(),
                _buildNickname(),
                Divider(),
                _buildGender(),
                Divider(),
                _buildBirthday(),
                Divider(),
                _buildIntroduction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // “完成”按钮
  _buildFinishButton(BuildContext context) {
    return Consumer2<PetProvider, ChooseAvatarProvider>(
      builder: (context, petProvider, chooseAvatarProvider, child) {
        print("添加完成按钮");
        return textBtnFlatButtonWidget(
          onPressed: () async {
            await petProvider.addPet(
              species: widget.species,
              avatar: chooseAvatarProvider.avatarNetworkPath,
              nickname: _nicknameController.text,
              gender: _gender,
              birthday: _birthday,
              intro: _introductionController.text,
            );
            if (petProvider.isIdle)
              Navigator.of(context).pop();
            else if (petProvider.isError) showToast("服务器错误");
          },
          title: "完成",
        );
      },
    );
  }

  // 宠物头像布局，并有拍摄，相册，默认三种选项
  Widget _buildAvatar(BuildContext context) {
    return Consumer<ChooseAvatarProvider>(
      builder: (context, chooseAvatarProvider, child) {
        var _networkAvatar = chooseAvatarProvider.avatarNetworkPath;
        return Center(
          child: Column(
            children: <Widget>[
              Container(
                width: cddSetWidth(70),
                height: cddSetWidth(70),
                child: ClipOval(
                  child: Image.network(
                    _networkAvatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: cddSetHeight(5)),
              textBtnFlatButtonWidget(
                  onPressed: () {
                    // 更改头像弹框
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => LoadingOverlay(
                        isLoading: chooseAvatarProvider.isBusy,
                        color: Colors.transparent,
                        child: chooseAvatarBottomSheetWidget(
                          context: context,
                          tapCamera: () async {
                            await chooseAvatarProvider.getImageFromCamera();
                            Navigator.of(context).pop();
                          },
                          tapGallery: () async {
                            await chooseAvatarProvider.getImageFromGallery();
                            Navigator.of(context).pop();
                          },
                          tapDefault: () async {
                            chooseAvatarProvider.setDefault(_defaultAvatar);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                  title: "点击更换",
                  textColor: AppColor.secondaryTextColor.withOpacity(0.6)),
            ],
          ),
        );
      },
    );
  }

  // 宠物昵称布局
  Widget _buildNickname() {
    return _buildFormListItem(
      "昵称",
      TextField(
        controller: _nicknameController,
        maxLength: 11,
        decoration: InputDecoration(
          counterText: "",
          hintText: "请输入宠物昵称",
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: AppColor.primaryText,
          fontWeight: FontWeight.w400,
          fontSize: cddSetFontSize(16),
        ),
      ),
    );
  }

  // 宠物性别布局
  Widget _buildGender() {
    return _buildFormListItem(
      "性别",
      Row(
        children: <Widget>[
          Flexible(
            child: RadioListTile(
              value: 0,
              title: Text("男"),
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
              title: Text("女"),
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

  // 宠物生日布局
  Widget _buildBirthday() {
    return _buildFormListItem(
      "出生日期",
      cddDatePickerWidget(
        context: context,
        dt: _birthday,
        onConfirm: (Picker picker, List value) {
          setState(() {
            _birthday = (picker.adapter as DateTimePickerAdapter).value;
          });
        },
      ),
    );
  }

  // 宠物介绍布局
  Widget _buildIntroduction() {
    return _buildFormListItem(
      "介绍",
      TextField(
        controller: _introductionController,
        maxLength: 20,
        decoration: InputDecoration(
          counterText: "",
          hintText: "介绍一下你的宠物吧",
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: AppColor.primaryText,
          fontWeight: FontWeight.w400,
          fontSize: cddSetFontSize(16),
        ),
      ),
    );
  }

  // 此页面表单格式布局
  Widget _buildFormListItem(String title, Widget operation) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: AppColor.secondaryTextColor.withOpacity(0.6),
            fontSize: cddSetFontSize(17),
          ),
        ),
        SizedBox(width: cddSetWidth(60)),
        Expanded(child: operation),
      ],
    );
  }
}

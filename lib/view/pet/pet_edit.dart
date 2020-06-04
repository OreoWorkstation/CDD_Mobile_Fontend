import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/choose_image_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class PetEditPage extends StatefulWidget {
  const PetEditPage({Key key, @required this.pet}) : super(key: key);
  final PetEntity pet;

  @override
  _PetEditPageState createState() => _PetEditPageState();
}

class _PetEditPageState extends State<PetEditPage> {
  // 宠物昵称控制器
  TextEditingController _nicknameController = TextEditingController();
  // 宠物介绍控制器
  TextEditingController _introductionController = TextEditingController();
  // 宠物生日，默认为当前时间
  DateTime _birthday = DateTime.now();
  // 宠物性别，默认为男
  int _gender = 0;
  // 宠物原始头像
  String _avatar = "";
  // 宠物种类
  String _species = "";
  // 宠物实体类
  PetEntity _pet;

  @override
  void initState() {
    super.initState();
    _pet = widget.pet;
    _nicknameController.text = _pet.nickname;
    _introductionController.text = _pet.introduction;
    _birthday = _pet.birthday;
    _gender = _pet.gender;
    _avatar = _pet.avatar;
    _species = _pet.species;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChooseImageProvider(_avatar),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text(
            "编辑",
            style: TextStyle(color: AppColor.dark, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          elevation: 0.6,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: AppColor.dark),
          ),
          actions: <Widget>[
            _buildFinishButton(context),
          ],
        ),
        body: Consumer<PetEditProvider>(
          builder: (_, petEditProvider, __) {
            return LoadingOverlay(
              isLoading: petEditProvider.isBusy,
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: sWidth(40),
                    right: sWidth(40),
                    top: sHeight(40),
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
            );
          },
        ),
      ),
    );
  }

  // “完成”按钮
  _buildFinishButton(BuildContext context) {
    return Consumer<PetEditProvider>(
      builder: (_, petEditProvider, __) {
        return IconButton(
          icon: Icon(
            Icons.done,
            color: AppColor.dark,
          ),
          onPressed: () async {
            _pet.avatar = _avatar;
            _pet.nickname = _nicknameController.text;
            _pet.gender = _gender;
            _pet.birthday = _birthday;
            _pet.introduction = _introductionController.text;
            bool _isSuccess = await petEditProvider.updatePet(pet: _pet);
            if (_isSuccess) {
              showToast("更新成功");
              Navigator.of(context).pop();
            } else {
              showToast("请求失败");
            }
          },
        );
      },
    );
  }

  // 宠物头像布局，并有拍摄，相册，默认三种选项
  Widget _buildAvatar(BuildContext context) {
    return Consumer<ChooseImageProvider>(
      builder: (_, chooseImageProvider, __) {
        _avatar = chooseImageProvider.imageNetworkPath;
        return Center(
          child: Column(
            children: <Widget>[
              Container(
                width: sWidth(70),
                height: sWidth(70),
                child: ClipOval(
                  child: Image.network(
                    _avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: sHeight(5)),
              textBtnFlatButtonWidget(
                  onPressed: () {
                    // 打开更改头像弹框
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          _buildChooseAvatarBottomSheet(chooseImageProvider),
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

  // 更改头像弹框布局
  Widget _buildChooseAvatarBottomSheet(
    ChooseImageProvider chooseImageProvider,
  ) {
    return LoadingOverlay(
      isLoading: chooseImageProvider.isBusy,
      color: Colors.transparent,
      child: chooseAvatarBottomSheetWidget(
        context: context,
        tapCamera: () async {
          await chooseImageProvider.getImageFromCamera();
          Navigator.of(context).pop();
        },
        tapGallery: () async {
          await chooseImageProvider.getImageFromGallery();
          Navigator.of(context).pop();
        },
        tapDefault: () async {
          chooseImageProvider
              .setDefault(_species == 'cat' ? CAT_AVATAR : DOG_AVATAR);
          Navigator.of(context).pop();
        },
      ),
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
          fontSize: sSp(16),
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
          fontSize: sSp(16),
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
            fontSize: sSp(17),
          ),
        ),
        SizedBox(width: sWidth(60)),
        Expanded(child: operation),
      ],
    );
  }
}

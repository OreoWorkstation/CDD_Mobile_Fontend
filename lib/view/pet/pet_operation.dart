import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';

class PetOperation extends StatefulWidget {
  final int petId;
  final String species;
  final String avatar;
  final String nickname;
  final String introduction;
  final int gender;
  final DateTime birthday;
  final int operation; // 0: 添加, 1: 更新

  const PetOperation({
    Key key,
    @required this.species,
    this.avatar,
    this.nickname,
    this.introduction,
    this.gender,
    this.birthday,
    @required this.operation,
    this.petId,
  }) : super(key: key);

  @override
  _PetOperationState createState() => _PetOperationState();
}

class _PetOperationState extends State<PetOperation> {
  APIResponse<bool> _apiResponse;

  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _introductionController = TextEditingController();

  int _gender = 0;

  DateTime _birthday = DateTime.now();

  String _avatar = "";

  bool _isFile = false;

  @override
  void initState() {
    _gender = widget.gender ?? 0;
    _birthday = widget.birthday ?? DateTime.now();
    _nicknameController.text = widget.nickname;
    _introductionController.text = widget.introduction;
    _avatar = widget.avatar ?? "";
    super.initState();
  }

  _handleFinishButton() async {
    if (widget.operation == 0) {
      _apiResponse = await PetAPI.insertPet(
        pet: PetEntity(
          userId: int.parse(Global.accessToken),
          nickname: _nicknameController.text,
          gender: _gender,
          avatar: _avatar,
          species: widget.species,
          birthday: _birthday,
          introduction: _introductionController.text,
        ),
      );
      if (_apiResponse.data == true) {
        Navigator.of(context).popUntil(ModalRoute.withName("/application"));
      } else {
        print(_apiResponse.errorMessage);
      }
    } else {
      _apiResponse = await PetAPI.updatePet(
        pet: PetEntity(
          id: widget.petId,
          userId: int.parse(Global.accessToken),
          avatar: _avatar,
          nickname: _nicknameController.text,
          gender: _gender,
          species: widget.species,
          birthday: _birthday,
          introduction: _introductionController.text,
        ),
      );
      if (_apiResponse.data == true) {
        print("Update success");
        Navigator.of(context).pop();
      } else {
        print(_apiResponse.errorMessage);
      }
    }
  }

  _handleCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      Navigator.of(context).pop();
    } else {
      var path = await MultipartFile.fromFile(image.path);
      var response = await FileAPI.uploadImage(imagePath: path);
      Navigator.of(context).pop();
      setState(() {
        _avatar = response.data;
      });
    }
  }

  _handleGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      Navigator.of(context).pop();
    } else {
      var path = await MultipartFile.fromFile(image.path);
      var response = await FileAPI.uploadImage(imagePath: path);
      Navigator.of(context).pop();
      setState(() {
        _avatar = response.data;
      });
    }
  }

  _handleDefault(context) {
    Navigator.of(context).pop();
    setState(() {
      _avatar = "";
    });
  }

  _handleChangeAvatar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: sHeight(350),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: sHeight(10), bottom: sHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "选择要执行的操作",
                    style: TextStyle(
                      fontSize: sSp(17),
                      color: AppColor.secondaryTextColor.withOpacity(0.7),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "拍摄",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sSp(17),
                      ),
                    ),
                    onTap: () => _handleCamera(context),
                  ),
                  ListTile(
                    title: Text("相册",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: sSp(17),
                        )),
                    onTap: () => _handleGallery(context),
                  ),
                  ListTile(
                    title: Text("默认头像",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: sSp(17),
                        )),
                    onTap: () => _handleDefault(context),
                  ),
                  ListTile(
                    title: Text("取消",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.secondaryTextColor,
                          fontSize: sSp(17),
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(widget.operation == 0 ? "添加宠物" : "编辑",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          textBtnFlatButtonWidget(onPressed: _handleFinishButton, title: "完成"),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: sWidth(40),
              right: sWidth(40),
              top: sHeight(40)),
          child: Column(
            children: <Widget>[
              _buildAvatar(context),
              Divider(),
              _buildNickName(),
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
  }

  _buildAvatar(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: sWidth(70),
            height: sWidth(70),
            child: ClipOval(
              child: _avatar == ""
                  ? Image.asset(
                      widget.species == "cat"
                          ? "assets/images/cat_avatar.jpg"
                          : "assets/images/dog_avatar.jpg",
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      _avatar,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: sHeight(5)),
          textBtnFlatButtonWidget(
              onPressed: () => _handleChangeAvatar(context),
              title: "点击更换",
              textColor: AppColor.secondaryTextColor.withOpacity(0.6)),
        ],
      ),
    );
  }

  _buildNickName() {
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
        ));
  }

  _buildGender() {
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

  _buildBirthday() {
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

  _buildIntroduction() {
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
        ));
  }

  _buildFormListItem(String title, Widget operation) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: AppColor.secondaryTextColor.withOpacity(0.6),
            fontSize: 17,
          ),
        ),
        SizedBox(width: sWidth(60)),
        Expanded(child: operation),
      ],
    );
  }
}

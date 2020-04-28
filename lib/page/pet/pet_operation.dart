import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

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

  _handleChangeAvatar() {
    print("press change avatar button");
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
              left: cddSetWidth(40),
              right: cddSetWidth(40),
              top: cddSetHeight(40)),
          child: Column(
            children: <Widget>[
              _buildAvatar(),
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

  _buildAvatar() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: cddSetWidth(70),
            height: cddSetWidth(70),
            child: ClipOval(
              child: _avatar == ""
                  ? Image.asset(
                      widget.species == "cat"
                          ? "assets/images/cat.jpg"
                          : "assets/images/dog.png",
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      _avatar,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: cddSetHeight(5)),
          textBtnFlatButtonWidget(
              onPressed: _handleChangeAvatar,
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
            fontSize: cddSetFontSize(16),
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
            fontSize: cddSetFontSize(16),
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
        SizedBox(width: cddSetWidth(60)),
        Expanded(child: operation),
      ],
    );
  }
}

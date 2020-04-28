import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/api_response.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class PetAddSecondPage extends StatefulWidget {
  final petSpecies;
  PetAddSecondPage({Key key, @required this.petSpecies}) : super(key: key);

  @override
  _PetAddSecondPageState createState() => _PetAddSecondPageState();
}

class _PetAddSecondPageState extends State<PetAddSecondPage> {
  APIResponse<bool> _apiResponse;

  int _genderValue = 0;
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _introductionController = TextEditingController();
  DateTime _dt = DateTime.now();

  // 处理添加宠物
  _handleAddPet() async {
    _apiResponse = await PetAPI.insertPet(
      pet: PetEntity(
        userId: int.parse(Global.accessToken),
        nickname: _nicknameController.text,
        gender: _genderValue,
        species: widget.petSpecies,
        birthday: _dt,
        introduction: _introductionController.text,
      ),
    );
    if (_apiResponse.data == true) {
      print("Add success");
      Navigator.of(context).pop();
    } else {
      print(_apiResponse.errorMessage);
    }
  }

  // 处理更改头像
  _handleChangeAvatar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text("添加宠物", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          textBtnFlatButtonWidget(onPressed: _handleAddPet, title: "完成"),
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

  // 选择头像
  _buildAvatar() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: cddSetWidth(70),
            height: cddSetWidth(70),
            child: ClipOval(
              child: Image.asset(
                widget.petSpecies == "cat"
                    ? "assets/images/cat.jpg"
                    : "assets/images/dog.png",
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

  // 构建昵称项
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

  // 构建性别项
  _buildGender() {
    return _buildFormListItem(
      "性别",
      Row(
        children: <Widget>[
          Flexible(
            child: RadioListTile(
              value: 0,
              title: Text("男"),
              groupValue: _genderValue,
              onChanged: (value) {
                setState(() {
                  _genderValue = value;
                });
              },
            ),
          ),
          Flexible(
            child: RadioListTile(
              value: 1,
              title: Text("女"),
              groupValue: _genderValue,
              onChanged: (value) {
                setState(() {
                  _genderValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // 构建出生日期项
  _buildBirthday() {
    return _buildFormListItem(
      "出生日期",
      cddDatePickerWidget(
        context: context,
        dt: _dt,
        onConfirm: (Picker picker, List value) {
          setState(() {
            _dt = (picker.adapter as DateTimePickerAdapter).value;
          });
        },
      ),
    );
  }

  //构建介绍项
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

  // 封装表单列表项格式
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

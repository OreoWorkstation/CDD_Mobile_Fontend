import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/page/diary/diary.dart';
import 'package:cdd_mobile_frontend/page/pet/pet_edit.dart';
import 'package:cdd_mobile_frontend/page/pet/pet_operation.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/dialog.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/page/cost/cost.dart';
import 'package:cdd_mobile_frontend/page/photo/photo.dart';
import 'package:cdd_mobile_frontend/page/weight/weight.dart';
import 'package:cdd_mobile_frontend/provider/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetPage extends StatefulWidget {
  PetPage({
    Key key,
    @required this.pet,
    @required this.index,
  }) : super(key: key);
  final PetEntity pet;
  final int index;

  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  PetEntity _pet;

  @override
  void initState() {
    super.initState();
    _pet = widget.pet;
  }

  @override
  Widget build(BuildContext context) {
    var petProvider = Provider.of<PetProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return commonBottomSheetWidget(
                    context: context,
                    tapEdit: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              PetEditPage(index: widget.index),
                        ),
                      );
                    },
                    tapDelete: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteConfirmDialog(
                            "确认删除宠物吗?",
                            () async {
                              await petProvider.deletePet(widget.index);
                              Navigator.of(context).popUntil(
                                ModalRoute.withName("/application"),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
            icon: Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: cddSetWidth(30)),
        child: Column(
          children: <Widget>[
            // 页面头部
            _buildHeader(_pet.avatar, _pet.species, _pet.nickname, _pet.gender),
            SizedBox(height: cddSetHeight(20)),
            // 宠物看板
            _buildPetBoard(_pet.birthday, _pet.species, _pet.introduction),
            SizedBox(height: cddSetHeight(20)),
            // 宠物数据
            _buildPetData(_pet.weight, _pet.diaryNumber, _pet.totalCost,
                _pet.photoNumber),
            SizedBox(height: cddSetHeight(20)),
            // 铲屎官
            _buildOtherPeople(),
          ],
        ),
      ),
    );
  }

  // 页面顶部：头像，昵称，性别
  Widget _buildHeader(
    String avatar,
    String species,
    String nickname,
    int gender,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: cddSetWidth(46),
          height: cddSetWidth(46),
          child: ClipOval(
            child: avatar == ""
                ? species == 'cat'
                    ? Image.asset(
                        "assets/images/cat_avatar.jpg",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/dog_avatar.jpg",
                        fit: BoxFit.cover,
                      )
                : Image.network(avatar, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: cddSetWidth(21)),
        Text(
          nickname,
          style: TextStyle(
            fontSize: cddSetFontSize(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: cddSetWidth(16)),
        gender == 0
            ? Icon(Iconfont.nan2, color: Colors.blue)
            : Icon(Iconfont.nv3, color: Color.fromARGB(255, 241, 158, 194)),
      ],
    );
  }

  // 宠物信息看板：饲养天数，生日，品种，介绍
  Widget _buildPetBoard(
    DateTime birthday,
    String species,
    String introduction,
  ) {
    return Container(
      height: cddSetHeight(158),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: Radii.k10pxRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: cddSetWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildPetBoardItem(
              Iconfont.rili,
              cddGetDifferenceInDay(birthday),
            ),
            _buildPetBoardItem(
              Iconfont.shengri,
              cddGetBirthdayWithoutYear(birthday),
            ),
            _buildPetBoardItem(
              Iconfont.pinzhong,
              species.toUpperCase(),
            ),
            _buildPetBoardItem(
              Iconfont.jieshao,
              introduction,
            ),
          ],
        ),
      ),
    );
  }

  // 宠物看板各项布局
  Widget _buildPetBoardItem(IconData icon, String value) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Color.fromARGB(255, 25, 61, 201)),
        SizedBox(width: cddSetWidth(25)),
        Text(
          value,
          style: TextStyle(fontSize: cddSetFontSize(13), color: Colors.black),
        ),
      ],
    );
  }

  // 宠物数据：体重，日记数量，消费，相册数量
  Widget _buildPetData(
    double weight,
    int diaryNumber,
    double totalCost,
    int photoNumber,
  ) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              AppColor.weightColor,
              Iconfont.weight,
              "体重值",
              "$weight Kg",
              () async {},
            ),
            _buildPetValueItem(
              AppColor.diaryColor,
              Iconfont.riji,
              "日记",
              "$diaryNumber",
              () {},
            ),
          ],
        ),
        SizedBox(height: cddSetHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              AppColor.costColor,
              Iconfont.zhangdan,
              "账单",
              "￥$totalCost",
              () async {},
            ),
            _buildPetValueItem(
              AppColor.photoColor,
              Iconfont.xiangce,
              "相册",
              "$photoNumber",
              () async {},
            ),
          ],
        ),
      ],
    );
  }

  // 各项宠物数据布局
  Widget _buildPetValueItem(
    Color bgColor,
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cddSetWidth(141),
        height: cddSetHeight(125),
        decoration: BoxDecoration(
          borderRadius: Radii.k10pxRadius,
          color: bgColor,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: cddSetWidth(10), top: cddSetHeight(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, size: cddSetFontSize(34), color: Colors.white),
                  SizedBox(width: cddSetWidth(14)),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: cddSetFontSize(17), color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: cddSetHeight(26)),
              Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: cddSetFontSize(17.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 铲屎官布局
  Widget _buildOtherPeople() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "铲屎官",
          style: TextStyle(
            fontSize: cddSetFontSize(20),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        IconButton(
          icon: Icon(
            Iconfont.tianjia,
            size: cddSetFontSize(28),
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

/*
class PetPage extends StatefulWidget {
  final int petId;
  PetPage({Key key, this.petId}) : super(key: key);

  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  APIResponse<PetEntity> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPetInfo();
  }

  // 获取宠物信息
  _fetchPetInfo() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await PetAPI.getPetByPetId(petId: widget.petId);
    setState(() {
      _isLoading = false;
    });
  }

  // 处理编辑宠物信息
  _handleEditPet(BuildContext context) async {
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => PetOperation(
        operation: 1,
        petId: _apiResponse.data.id,
        species: _apiResponse.data.species,
        avatar: _apiResponse.data.avatar,
        birthday: _apiResponse.data.birthday,
        nickname: _apiResponse.data.nickname,
        introduction: _apiResponse.data.introduction,
        gender: _apiResponse.data.gender,
      ),
    ));
    _fetchPetInfo();
  }

  // 处理删除宠物
  _handleDeletePet(context) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmDialog(
          "确认删除宠物吗?",
          () async {
            await PetAPI.deletePet(petId: widget.petId);
            Navigator.popUntil(context, ModalRoute.withName("/application"));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openBottomSheet(context),
            icon: Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: cddSetWidth(30)),
              child: Column(
                children: <Widget>[
                  _buildPetHeader(),
                  SizedBox(height: cddSetHeight(20)),
                  _buildPetBoard(),
                  SizedBox(height: cddSetHeight(20)),
                  _buildPetValue(),
                  SizedBox(height: cddSetHeight(20)),
                  _buildOtherPeople(),
                ],
              ),
            ),
    );
  }

  // 打开底部弹窗
  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return commonBottomSheetWidget(
          context: context,
          editOnTap: () => _handleEditPet(context),
          deleteOnTap: () => _handleDeletePet(context),
        );
      },
    );
  }

  // 构建宠物界面头部信息
  Widget _buildPetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: cddSetWidth(46),
          height: cddSetWidth(46),
          child: ClipOval(
            child: _apiResponse.data.avatar == ""
                ? _apiResponse.data.species == 'cat'
                    ? Image.asset("assets/images/cat_avatar.jpg",
                        fit: BoxFit.cover)
                    : Image.asset("assets/images/dog_avatar.jpg",
                        fit: BoxFit.cover)
                : Image.network(_apiResponse.data.avatar, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: cddSetWidth(21)),
        Text(
          _apiResponse.data.nickname,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: cddSetWidth(16)),
        _apiResponse.data.gender == 0
            ? Icon(Iconfont.nan2, color: Colors.blue)
            : Icon(Iconfont.nv3, color: Color.fromARGB(255, 241, 158, 194)),
      ],
    );
  }

  // 构建宠物看板
  Widget _buildPetBoard() {
    return Container(
      height: cddSetHeight(158),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: Radii.k10pxRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: cddSetWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildPetBoardItem(
              Iconfont.rili,
              cddGetDifferenceInDay(_apiResponse.data.birthday),
            ),
            _buildPetBoardItem(
              Iconfont.shengri,
              cddGetBirthdayWithoutYear(_apiResponse.data.birthday),
            ),
            _buildPetBoardItem(
              Iconfont.pinzhong,
              _apiResponse.data.species.toUpperCase(),
            ),
            _buildPetBoardItem(
              Iconfont.jieshao,
              _apiResponse.data.introduction,
            ),
          ],
        ),
      ),
    );
  }

  // 构建宠物各项属性值
  Widget _buildPetValue() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              AppColor.weightColor,
              Iconfont.weight,
              "体重值",
              "${_apiResponse.data.weight} Kg",
              () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WeightPage(petId: widget.petId),
                ));
                _fetchPetInfo();
              },
            ),
            _buildPetValueItem(
              AppColor.diaryColor,
              Iconfont.riji,
              "日记",
              "${_apiResponse.data.diaryNumber}",
              () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DiaryPage(petId: widget.petId),
                ));
              },
            ),
          ],
        ),
        SizedBox(height: cddSetHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              AppColor.costColor,
              Iconfont.zhangdan,
              "账单",
              "￥${_apiResponse.data.totalCost}",
              () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CostPage(petId: widget.petId),
                ));
                _fetchPetInfo();
              },
            ),
            _buildPetValueItem(
              AppColor.photoColor,
              Iconfont.xiangce,
              "相册",
              "${_apiResponse.data.photoNumber}",
              () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PhotoPage(),
                ));
                _fetchPetInfo();
              },
            ),
          ],
        ),
      ],
    );
  }

  // 构建铲屎官
  Widget _buildOtherPeople() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "铲屎官",
          style: TextStyle(
              fontSize: cddSetFontSize(20),
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        IconButton(
          icon: Icon(
            Iconfont.tianjia,
            size: cddSetFontSize(28),
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  // 宠物看板item
  Widget _buildPetBoardItem(IconData icon, String str) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Color.fromARGB(255, 25, 61, 201)),
        SizedBox(width: cddSetWidth(25)),
        Text(
          str,
          style: TextStyle(fontSize: cddSetFontSize(13), color: Colors.black),
        ),
      ],
    );
  }

  // 宠物ValueItem
  Widget _buildPetValueItem(
    Color bgColor,
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cddSetWidth(141),
        height: cddSetHeight(125),
        decoration: BoxDecoration(
          borderRadius: Radii.k10pxRadius,
          color: bgColor,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: cddSetWidth(10), top: cddSetHeight(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, size: cddSetFontSize(34), color: Colors.white),
                  SizedBox(width: cddSetWidth(14)),
                  Text(title,
                      style: TextStyle(
                          fontSize: cddSetFontSize(17), color: Colors.white)),
                ],
              ),
              SizedBox(height: cddSetHeight(26)),
              Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: cddSetFontSize(17.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/

import 'package:cdd_mobile_frontend/page/pet/pet_edit.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/dialog.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/page/weight/weight.dart';
import 'package:cdd_mobile_frontend/provider/pet_provider.dart';
import 'package:cdd_mobile_frontend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetPage extends StatefulWidget {
  PetPage({
    Key key,
    @required this.id,
  }) : super(key: key);
  final int id;

  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
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
                          return Consumer2<UserProvider, PetProvider>(
                            builder:
                                (context, userProvider, petProvider, child) {
                              return DeleteConfirmDialog(
                                "确认删除宠物吗?",
                                () async {
                                  await petProvider.deletePet(widget.id);
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
            _buildHeader(),
            SizedBox(height: cddSetHeight(20)),
            // 宠物看板
            _buildPetBoard(),
            SizedBox(height: cddSetHeight(20)),
            // 宠物数据
            _buildPetData(),
            SizedBox(height: cddSetHeight(20)),
            // 铲屎官
            _buildOtherPeople(),
          ],
        ),
      ),
    );
  }

  // 页面顶部：头像，昵称，性别
  Widget _buildHeader() {
    return Consumer<PetProvider>(
      builder: (_, petProvider, __) {
        var pet = petProvider.petList[widget.index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: cddSetWidth(46),
              height: cddSetWidth(46),
              child: ClipOval(
                child: pet.avatar == ""
                    ? pet.species == 'cat'
                        ? Image.asset(
                            "assets/images/cat_avatar.jpg",
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/dog_avatar.jpg",
                            fit: BoxFit.cover,
                          )
                    : Image.network(pet.avatar, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: cddSetWidth(21)),
            Text(
              pet.nickname,
              style: TextStyle(
                fontSize: cddSetFontSize(20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: cddSetWidth(16)),
            pet.gender == 0
                ? Icon(Iconfont.nan2, color: Colors.blue)
                : Icon(Iconfont.nv3, color: Color.fromARGB(255, 241, 158, 194)),
          ],
        );
      },
    );
  }

  // 宠物信息看板：饲养天数，生日，品种，介绍
  Widget _buildPetBoard() {
    return Consumer<PetProvider>(
      builder: (_, petProvider, __) {
        if (widget.index >= petProvider.petList.length) return Container();
        var pet = petProvider.petList[widget.index];
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
                  cddGetDifferenceInDay(pet.birthday),
                ),
                _buildPetBoardItem(
                  Iconfont.shengri,
                  cddGetBirthdayWithoutYear(pet.birthday),
                ),
                _buildPetBoardItem(
                  Iconfont.pinzhong,
                  pet.species.toUpperCase(),
                ),
                _buildPetBoardItem(
                  Iconfont.jieshao,
                  pet.introduction,
                ),
              ],
            ),
          ),
        );
      },
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
  Widget _buildPetData() {
    return Consumer<PetProvider>(
      builder: (context, petProvider, child) {
        if (widget.index >= petProvider.petList.length) return Container();
        var _pet = petProvider.petList[widget.index];
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildPetValueItem(
                  AppColor.weightColor,
                  Iconfont.weight,
                  "体重值",
                  "${_pet.weight} Kg",
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WeightPage(
                        petId: _pet.id,
                        petIndex: widget.index,
                      ),
                    ));
                  },
                ),
                _buildPetValueItem(
                  AppColor.diaryColor,
                  Iconfont.riji,
                  "日记",
                  "${_pet.diaryNumber}",
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
                  "￥${_pet.totalCost}",
                  () async {},
                ),
                _buildPetValueItem(
                  AppColor.photoColor,
                  Iconfont.xiangce,
                  "相册",
                  "${_pet.photoNumber}",
                  () async {},
                ),
              ],
            ),
          ],
        );
      },
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

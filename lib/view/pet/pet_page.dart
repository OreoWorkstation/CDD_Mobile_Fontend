import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/cost/cost.dart';
import 'package:cdd_mobile_frontend/view/diary/diary.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_edit.dart';
import 'package:cdd_mobile_frontend/view/photo/photo.dart';
import 'package:cdd_mobile_frontend/view/weight/weight.dart';
import 'package:cdd_mobile_frontend/view_model/cost/cost_list_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_delete_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_edit_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_provider.dart';
import 'package:cdd_mobile_frontend/view_model/photo/photo_list_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:cdd_mobile_frontend/view_model/weight/weight_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
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
  // 处理编辑宠物信息
  _handleEditPet(PetEntity pet) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => PetEditProvider(),
          child: PetEditPage(pet: pet),
        ),
      ),
    );
  }

  // 处理删除宠物
  // TODO: 需要通知用户界面更改宠物数量
  _handleDeletePet() {
    showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => PetDeleteProvider(),
          child: Consumer2<UserProvider, PetDeleteProvider>(
            builder: (_, userProvider, petDeleteProvider, __) {
              return LoadingOverlay(
                isLoading: petDeleteProvider.isBusy,
                color: Colors.transparent,
                child: DeleteConfirmDialog(
                  "确认删除宠物吗?",
                  () async {
                    await petDeleteProvider.deletePet(widget.id);
                    Navigator.of(context).popUntil(
                      ModalRoute.withName("/application"),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

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
          // 更多按钮
          Consumer<PetProvider>(
            builder: (_, petProvider, __) {
              return IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.black),
                onPressed: () {
                  // 打开底部弹框
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return commonBottomSheetWidget(
                        context: context,
                        tapEdit: () => _handleEditPet(petProvider.pet),
                        tapDelete: () => _handleDeletePet(),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _buildPetBody(context),
    );
  }

  // 页面内容
  Widget _buildPetBody(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (_, petProvider, __) => Builder(
        builder: (_) {
          // 正在请求数据
          if (petProvider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          // 请求出错
          if (petProvider.isError) {
            return Center(child: Text("Error occurred!"));
          }
          var _pet = petProvider.pet;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: sWidth(30)),
            child: Column(
              children: <Widget>[
                // 页面头部
                _buildHeader(_pet),
                SizedBox(height: sHeight(20)),
                // 宠物看板
                _buildPetBoard(_pet),
                SizedBox(height: sHeight(20)),
                // 宠物数据
                _buildPetData(_pet, petProvider),
                //SizedBox(height: sHeight(20)),
                // 铲屎官
                //_buildOtherPeople(),
              ],
            ),
          );
        },
      ),
    );
  }

  // 页面顶部：头像，昵称，性别
  Widget _buildHeader(PetEntity pet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: sWidth(46),
          height: sWidth(46),
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
        SizedBox(width: sWidth(21)),
        Text(
          pet.nickname,
          style: TextStyle(
            fontSize: sSp(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: sWidth(16)),
        pet.gender == 0
            ? Icon(Iconfont.nan2, color: Colors.blue)
            : Icon(Iconfont.nv3, color: Color.fromARGB(255, 241, 158, 194)),
      ],
    );
  }

  // 宠物信息看板：饲养天数，生日，品种，介绍
  Widget _buildPetBoard(PetEntity pet) {
    return Container(
      height: sHeight(158),
      decoration: BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.only(left: sWidth(20)),
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
  }

  // 宠物看板各项布局
  Widget _buildPetBoardItem(IconData icon, String value) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Color.fromARGB(255, 25, 61, 201)),
        SizedBox(width: sWidth(25)),
        Text(
          value,
          style: TextStyle(fontSize: sSp(13), color: Colors.black),
        ),
      ],
    );
  }

  // 宠物数据：体重，日记数量，消费，相册数量
  Widget _buildPetData(PetEntity pet, PetProvider petProvider) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              AppColor.weightColor,
              Iconfont.weight,
              "体重值",
              "${pet.weight} Kg",
              () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => WeightListProvider(pet.id),
                      child: WeightPage(),
                    ),
                  ),
                );
                petProvider.fetchPet();
              },
            ),
            _buildPetValueItem(
              AppColor.diaryColor,
              Iconfont.riji,
              "日记",
              "${pet.diaryNumber}",
              () async {
                // await Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => ChangeNotifierProvider(
                //       create: (_) => WeightListProvider(pet.id),
                //       child: WeightPage(),
                //     ),
                //   ),
                // );
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DiaryPage(
                      petId: petProvider.pet.id,
                    ),
                  ),
                );
                petProvider.fetchPet();
              },
            ),
          ],
        ),
        SizedBox(height: sHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              AppColor.costColor,
              Iconfont.zhangdan,
              "账单",
              "￥${pet.totalCost}",
              () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => CostListProvider(pet.id),
                      child: CostPage(),
                    ),
                  ),
                );
                petProvider.fetchPet();
              },
            ),
            _buildPetValueItem(
              AppColor.photoColor,
              Iconfont.xiangce,
              "相册",
              "${pet.photoNumber}",
              () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => PhotoListProvider(pet.id),
                      child: PhotoPage(),
                    ),
                  ),
                );
                petProvider.fetchPet();
              },
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
        width: sWidth(141),
        height: sHeight(125),
        decoration: BoxDecoration(
          borderRadius: Radii.k10pxRadius,
          color: bgColor,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: sWidth(10), top: sHeight(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, size: sSp(34), color: Colors.white),
                  SizedBox(width: sWidth(14)),
                  Text(
                    title,
                    style: TextStyle(fontSize: sSp(17), color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: sHeight(26)),
              Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sSp(17.0),
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
            fontSize: sSp(20),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        IconButton(
          icon: Icon(
            Iconfont.tianjia,
            size: sSp(28),
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

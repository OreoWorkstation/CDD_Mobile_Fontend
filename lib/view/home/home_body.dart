import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_add_first.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_page.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_list_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBarWidget(bgColor: Colors.transparent),
      body: Column(
        children: <Widget>[
          // 添加宠物布局
          _buildAddPet(context),
          SizedBox(height: sHeight(20)),
          // 宠物列表布局
          _buildPetList(context),
        ],
      ),
    );
  }

  // 添加宠物
  Widget _buildAddPet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: sWidth(43.0),
        right: sWidth(43.0),
        top: sHeight(250 - MediaQuery.of(context).padding.top),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "宠物",
            style: TextStyle(
              fontSize: sSp(20.0),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Consumer2<UserProvider, PetListProvider>(
            builder: (_, userProvider, petListProvider, __) {
              return IconButton(
                color: Colors.black,
                icon: Icon(
                  Iconfont.tianjia,
                  size: sSp(28.0),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PetAddFirstPage(),
                    ),
                  );
                  petListProvider.fetchPetList();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // 宠物列表
  Widget _buildPetList(BuildContext context) {
    return Consumer<PetListProvider>(
      builder: (_, petListProvider, __) => Builder(
        builder: (_) {
          // 正在请求数据
          if (petListProvider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          // 请求出错
          if (petListProvider.isError) {
            return Container(child: Text("请求出错"));
          }
          // 该用户没有宠物
          if (petListProvider.petList.length == 0) {
            return Center(child: Text("No pet.."));
          }
          return SizedBox(
            height: sHeight(320),
            child: Swiper(
              onTap: (index) async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) =>
                          PetProvider(petListProvider.petList[index].id),
                      child: PetPage(
                        id: petListProvider.petList[index].id,
                      ),
                    ),
                  ),
                );
                petListProvider.fetchPetList();
              },
              itemBuilder: (context, index) {
                return _buildPetCard(petListProvider.petList[index]);
              },
              itemCount: petListProvider.petList.length,
              viewportFraction: 0.5,
              scale: 0.6,
              loop: false,
              pagination: SwiperPagination(
                margin: EdgeInsets.only(bottom: sHeight(5)),
                builder: SwiperPagination.dots,
              ),
            ),
          );
        },
      ),
    );
  }

  // 宠物卡片
  Widget _buildPetCard(PetEntity pet) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Radii.k10pxRadius,
        gradient: AppColor.petCardColors[pet.species == 'cat' ? 0 : 1],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 宠物图标，系统默认
          _buildPetIcon(pet.species),
          // 宠物头像
          _buildPetAvatar(pet.avatar, pet.species),
          SizedBox(height: sHeight(15)),
          // 宠物姓名
          _buildPetNickname(pet.nickname),
          SizedBox(height: sHeight(15)),
          // 宠物年龄
          _buildPetAge(pet.birthday),
          SizedBox(height: sHeight(10)),
          // 宠物介绍
          _buildPetIntroduction(pet.introduction),
        ],
      ),
    );
  }

  // 宠物卡片上的宠物图标
  Widget _buildPetIcon(String species) {
    return Padding(
      padding: EdgeInsets.only(
        left: sWidth(10.0),
        top: sHeight(10.0),
      ),
      child: species == "cat"
          ? Icon(
        Iconfont.cat,
        size: sSp(40.0),
        color: Colors.white,
      )
          : Icon(
        Iconfont.dog4,
        size: sSp(40.0),
        color: Colors.white,
      ),
    );
  }

  // 宠物卡片上的宠物头像
  Widget _buildPetAvatar(String avatar, String species) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: sHeight(15.0)),
          height: sWidth(100),
          width: sWidth(100),
          child: ClipOval(
            child: avatar == ""
                ? species == "cat"
                ? Image.asset("assets/images/cat_avatar.jpg",
                fit: BoxFit.cover)
                : Image.asset("assets/images/dog_avatar.jpg",
                fit: BoxFit.cover)
                : Image.network(avatar, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  // 宠物卡片上的宠物名称
  Widget _buildPetNickname(String nickname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          nickname,
          style: TextStyle(
            fontSize: sSp(16),
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // 宠物卡片上宠物的年龄
  Widget _buildPetAge(DateTime birthday) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${cddGetAge(birthday)} years old",
          style: TextStyle(
            fontSize: sSp(14),
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // 宠物卡片上宠物的介绍
  Widget _buildPetIntroduction(String introduction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          introduction,
          style: TextStyle(
            fontSize: sSp(14),
            color: Colors.black.withOpacity(0.7),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
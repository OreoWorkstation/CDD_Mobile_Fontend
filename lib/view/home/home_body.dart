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

const List<Color> _colorList = [
  Color(0xFFF5B041),
  Color(0xFFBB68E1),
];

// class HomeBody extends StatefulWidget {
//   final PetListProvider petListProvider;
//   HomeBody({Key key, this.petListProvider}) : super(key: key);

//   @override
//   _HomeBodyState createState() => _HomeBodyState();
// }

// class _HomeBodyState extends State<HomeBody> {
//   PetListProvider _provider;
//   @override
//   void initState() {
//     super.initState();
//     _provider = widget.petListProvider;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _provider.petList.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () async {
//             await Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ChangeNotifierProvider(
//                   create: (_) => PetProvider(_provider.petList[index].id),
//                   child: PetPage(
//                     id: _provider.petList[index].id,
//                   ),
//                 ),
//               ),
//             );
//             _provider.fetchPetList();
//           },
//           child: _buildPetListItem(
//               _provider.petList[index], _colorList[index % _colorList.length]),
//           // child: _buildPetListItem(provider.petList[index], Colors.white),
//         );
//       },
//     );
//   }

//   Widget _buildPetListItem(PetEntity pet, Color color) {
//     return Container(
//       margin:
//           EdgeInsets.symmetric(horizontal: sWidth(20), vertical: sHeight(10)),
//       padding:
//           EdgeInsets.symmetric(horizontal: sWidth(16), vertical: sHeight(16)),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.bottomRight,
//             child: pet.species == 'cat'
//                 ? Icon(
//                     Iconfont.cat,
//                     color: AppColor.primary.withOpacity(.7),
//                     size: sSp(28),
//                   )
//                 : Icon(
//                     Iconfont.dog4,
//                     color: AppColor.primary.withOpacity(.7),
//                     size: sSp(28),
//                   ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Row(
//               children: <Widget>[
//                 Hero(
//                   tag: pet.nickname,
//                   child: AnimatedContainer(
//                     duration: Duration(milliseconds: 500),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.white,
//                         width: sWidth(2),
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: CircleAvatar(
//                       maxRadius: sWidth(60) / 2,
//                       backgroundColor: Colors.white,
//                       backgroundImage: NetworkImage(pet.avatar),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: sWidth(20)),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       pet.nickname,
//                       style: TextStyle(
//                         fontSize: sSp(17),
//                         color: AppColor.dark,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: sHeight(12)),
//                     Container(
//                         width: sWidth(200),
//                         child: Text(
//                           pet.introduction,
//                           style: TextStyle(
//                             fontSize: sSp(15),
//                             color: AppColor.grey,
//                           ),
//                           softWrap: true,
//                         )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PetListProvider>(context, listen: false).fetchPetList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBarWidget(bgColor: Colors.transparent),
      body: Column(
        children: <Widget>[
          SizedBox(height: sHeight(10)),
          // 添加宠物布局
          _buildAddPet(context),
          SizedBox(height: sHeight(30)),
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
            return Center(
                child: Text(
              "赶快添加你的宠物吧！",
              style: TextStyle(
                color: AppColor.lightGrey,
                fontSize: sSp(18),
                fontWeight: FontWeight.bold,
              ),
            ));
          }
          return SizedBox(
            height: sHeight(280),
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
                alignment: Alignment.bottomCenter,
                // margin: EdgeInsets.only(bottom: sHeight(5)),
                builder: DotSwiperPaginationBuilder(
                  activeColor: AppColor.primary,
                  color: Colors.grey,
                ),
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
        // gradient: AppColor.petCardColors[pet.species == 'cat' ? 0 : 1],
        // color: _colorList[pet.species == 'cat' ? 0 : 1],
        // color: Color(0xFFF7F9F9),
        color: AppColor.background,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.grey.withOpacity(.1),
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 宠物图标，系统默认
          _buildPetIcon(pet.species),
          // 宠物头像
          _buildPetAvatar(pet.avatar, pet.species),
          SizedBox(height: sHeight(30)),
          // 宠物姓名
          _buildPetNickname(pet.nickname),
          SizedBox(height: sHeight(10)),
          // 宠物年龄
          _buildPetAge(pet.birthday),
          SizedBox(height: sHeight(10)),
          // 宠物介绍
          // _buildPetIntroduction(pet.introduction),
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
              size: sSp(30.0),
              color: _colorList[0],
            )
          : Icon(
              Iconfont.dog4,
              size: sSp(30.0),
              color: _colorList[1],
            ),
    );
  }

  // 宠物卡片上的宠物头像
  Widget _buildPetAvatar(String avatar, String species) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // AnimatedContainer(
        //   margin: EdgeInsets.only(top: sHeight(15.0)),
        //   duration: Duration(milliseconds: 500),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: Colors.white70,
        //       width: sWidth(2),
        //     ),
        //     shape: BoxShape.circle,
        //   ),
        //   child: CircleAvatar(
        //     maxRadius: sWidth(100) / 2,
        //     backgroundColor: Colors.white,
        //     backgroundImage: avatar == ""
        //         ? species == "cat"
        //             ? AssetImage("assets/images/cat_avatar.jpg")
        //             : AssetImage("assets/images/dog_avatar.jpg")
        //         : NetworkImage(avatar),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: sHeight(15.0)),
          height: sWidth(90),
          width: sWidth(90),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: avatar == ""
                      ? species == 'cat'
                          ? AssetImage("assets/images/cat_avatar.jpg")
                          : AssetImage("assets/images/dog_avatar.jpg")
                      : NetworkImage(avatar),
                  fit: BoxFit.cover)),
          // child: ClipOval(
          //   child: avatar == ""
          //       ? species == "cat"
          //           ? Image.asset("assets/images/cat_avatar.jpg",
          //               fit: BoxFit.cover)
          //           : Image.asset("assets/images/dog_avatar.jpg",
          //               fit: BoxFit.cover)
          //       : Image.network(avatar, fit: BoxFit.cover),
          // ),
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
              color: AppColor.dark,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // 宠物卡片上宠物的年龄
  Widget _buildPetAge(DateTime birthday) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        cddGetAge(birthday) == 0
            ? Text(
                "${cddGetDifferenceInDay(birthday)}",
                style: TextStyle(
                  fontSize: sSp(14),
                  color: AppColor.grey,
                ),
              )
            : Text(
                "${cddGetAge(birthday)} 岁",
                style: TextStyle(
                  fontSize: sSp(14),
                  color: AppColor.grey,
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
        Container(
          width: sWidth(150),
          child: Center(
            child: Text(
              introduction,
              style: TextStyle(fontSize: sSp(14), color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}

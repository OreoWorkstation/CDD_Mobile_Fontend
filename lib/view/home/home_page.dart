import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/home/home_body.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_add_first.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_page.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_list_provider.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int type;

  const HomePage({Key key, this.type = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (_) => PetListProvider(),
    //   child: Consumer<PetListProvider>(
    //     builder: (_, provider, __) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           elevation: 0.6,
    //           centerTitle: true,
    //           title: Text(
    //             widget.type == 0 ? "首页" : "宠物列表",
    //             style: TextStyle(
    //                 color: AppColor.dark, fontWeight: FontWeight.w500),
    //           ),
    //           actions: <Widget>[
    //             IconButton(
    //               icon: Icon(
    //                 Icons.add,
    //                 color: AppColor.dark,
    //               ),
    //               onPressed: () async {
    //                 await Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (context) => PetAddFirstPage(),
    //                   ),
    //                 );
    //                 provider.fetchPetList();
    //               },
    //             ),
    //           ],
    //           leading: widget.type == 1
    //               ? IconButton(
    //                   icon: Icon(
    //                     Icons.arrow_back,
    //                     color: AppColor.dark,
    //                   ),
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                 )
    //               : null,
    //           backgroundColor: Colors.white,
    //           brightness: Brightness.light,
    //         ),
    //         body: Builder(
    //           builder: (_) {
    //             // 正在请求数据
    //             if (provider.isBusy) {
    //               return Center(child: CircularProgressIndicator());
    //             }
    //             // 请求出错
    //             if (provider.isError) {
    //               return Container(child: Text("请求出错"));
    //             }
    //             // 该用户没有宠物
    //             if (provider.petList.length == 0) {
    //               return Center(child: Text("No pet.."));
    //             }
    //             return HomeBody();
    //           },
    //         ),
    //       );
    //     },
    //   ),
    // );
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: sHeight(250),
          child: Image.asset(
            "assets/images/pet_header.png",
            fit: BoxFit.cover,
          ),
        ),
        HomeBody(),
      ],
    );
  }
}

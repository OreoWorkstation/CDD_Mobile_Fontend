import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PetEntity> _pets;

  bool _isLoading = false;

  // 处理添加宠物按钮
  _handleAddPetButton() {
    print("Press add pet");
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
    _loadAllData();
  }

  _loadAllData() async {
    _pets = await PetAPI.pets(userId: int.parse(Global.accessToken));
    setState(() {
      _isLoading = false;
    });
    print(_pets);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: cddSetHeight(300.0),
          child: Image.asset(
            "assets/images/pet_header.png",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBarWidget(bgColor: Colors.transparent),
          body: Column(
            children: <Widget>[
              _buildAddPet(),
              SizedBox(height: cddSetHeight(10)),
              _buildPetList(),
              SizedBox(height: cddSetHeight(10)),
            ],
          ),
        ),
      ],
    );
  }

  // 添加宠物
  Widget _buildAddPet() {
    return Padding(
      padding: EdgeInsets.only(
        left: cddSetWidth(43.0),
        right: cddSetWidth(43.0),
        top: cddSetHeight(300 - MediaQuery.of(context).padding.top),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "宠物",
            style: TextStyle(
              fontSize: cddSetFontSize(20.0),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(
              Iconfont.tianjia,
              size: cddSetFontSize(28.0),
            ),
            onPressed: _handleAddPetButton,
          ),
        ],
      ),
    );
  }

  // 宠物列表
  Widget _buildPetList() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Swiper(
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey,
                  );
                },
                itemCount: 4,
                viewportFraction: 0.5,
                scale: 0.9,
                loop: false,
              ),
            ),
          );
  }
}

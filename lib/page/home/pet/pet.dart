import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {
              print("press action");
            },
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

  // 构建宠物界面头部信息
  Widget _buildPetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: cddSetWidth(46),
          height: cddSetWidth(46),
          child: ClipOval(
            child: Image.network(_apiResponse.data.avatar, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: cddSetWidth(21)),
        Text(
          _apiResponse.data.nickname,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: cddSetWidth(16)),
        Icon(Iconfont.nv3, color: Color.fromARGB(255, 241, 158, 194)),
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
              Color.fromARGB(255, 68, 217, 168),
              Iconfont.weight,
              "体重值",
              "${_apiResponse.data.weight} Kg",
              () {},
            ),
            _buildPetValueItem(
              Color.fromARGB(255, 63, 100, 245),
              Iconfont.riji,
              "日记",
              "${_apiResponse.data.diaryNumber}",
              () {},
            ),
          ],
        ),
        SizedBox(height: cddSetHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPetValueItem(
              Color.fromARGB(255, 197, 109, 241),
              Iconfont.zhangdan,
              "账单",
              "￥${_apiResponse.data.totalCost}",
              () {},
            ),
            _buildPetValueItem(
              Color.fromARGB(255, 250, 59, 148),
              Iconfont.xiangce,
              "相册",
              "${_apiResponse.data.photoNumber}",
              () {},
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

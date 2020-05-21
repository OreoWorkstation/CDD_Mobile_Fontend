import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/view/pet/pet_add_second.dart';
import 'package:flutter/material.dart';

class PetAddFirstPage extends StatelessWidget {
  const PetAddFirstPage({Key key}) : super(key: key);

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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sWidth(23),
          vertical: sHeight(60),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: sHeight(32)),
            _buildPetOption(context),
          ],
        ),
      ),
    );
  }

  // 头部文字布局
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "选择宠物类别",
          style: TextStyle(
            fontSize: sSp(17),
            color: Colors.black,
          ),
        )
      ],
    );
  }

  // 宠物选项布局
  Widget _buildPetOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildPetOptionCart(context, "assets/images/cat.jpg", 0),
        _buildPetOptionCart(context, "assets/images/dog.png", 1),
      ],
    );
  }

  Widget _buildPetOptionCart(
    BuildContext context,
    String imagePath,
    int species,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    PetAddSecondPage(species: species == 0 ? "cat" : "dog"),
              ),
            );
          },
          child: Container(
            width: sWidth(150),
            height: sHeight(170),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: Radii.k10pxRadius,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: sHeight(10)),
        Text(
          species == 0 ? "猫" : "狗",
          style: TextStyle(fontSize: sSp(17), color: Colors.black),
        ),
      ],
    );
  }
}

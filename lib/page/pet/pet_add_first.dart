import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/page/pet/pet_add_second.dart';
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
        padding: EdgeInsets.symmetric(horizontal: cddSetWidth(23)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: cddSetHeight(60)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "选择宠物类别",
                  style: TextStyle(
                    fontSize: cddSetFontSize(17),
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(height: cddSetHeight(32)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildPetOptionCart(context, "assets/images/cat.jpg", "猫"),
                _buildPetOptionCart(context, "assets/images/dog.png", "狗"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetOptionCart(
      BuildContext context, String imagePath, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  PetAddSecondPage(petSpecies: title == "猫" ? "cat" : "dog"),
            ));
          },
          child: Container(
            width: cddSetWidth(150),
            height: cddSetHeight(170),
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
        SizedBox(height: cddSetHeight(10)),
        Text(title,
            style:
                TextStyle(fontSize: cddSetFontSize(17), color: Colors.black)),
      ],
    );
  }
}

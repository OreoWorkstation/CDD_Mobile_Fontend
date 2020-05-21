import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/view/home/home_body.dart';
import 'package:cdd_mobile_frontend/view_model/pet/pet_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: sHeight(250.0),
          child: Image.asset(
            "assets/images/pet_header.png",
            fit: BoxFit.cover,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PetListProvider(),
          child: HomeBody(),
        ),
      ],
    );
  }
}

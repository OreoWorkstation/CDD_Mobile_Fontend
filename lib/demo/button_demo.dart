import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';
class ButtonDemoPage extends StatefulWidget {
  @override
  _ButtonDemoPageState createState() => _ButtonDemoPageState();
}

class _ButtonDemoPageState extends State<ButtonDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Button Demo"),
      ),
      body: _buildButton(),
    );
  }

  Widget _buildButton() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: sHeight(45),
            width: sWidth(250),
            decoration: BoxDecoration(
              color: Colours.app_main,
              //color: Color(0xff2ECC71),
              borderRadius: Radii.k24pxRadius,
            ),
            child: FlatButton(
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: sSp(20)),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: sHeight(20)),
          Container(
            height: sHeight(45),
            width: sWidth(250),
            decoration: BoxDecoration(
//              color: Colors.black,
              color: Color(0xffE74C3C),
              borderRadius: Radii.k24pxRadius,
            ),
            child: FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white, fontSize: sSp(20)),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: sHeight(20)),
          Container(
            height: sHeight(45),
            width: sWidth(250),
            decoration: BoxDecoration(
              color: Colours.dark_app_main,
              borderRadius: Radii.k24pxRadius,
            ),
            child: FlatButton(
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: sSp(20)),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: sHeight(20)),
          Container(
            height: sHeight(34),
            decoration: BoxDecoration(
//              color: Colours.app_main,
              //color: Color(0xff2ECC71),
              color: Colours.dark_button_disabled,
              borderRadius: Radii.k24pxRadius,
            ),
            child: FlatButton(
              child: Text(
                "Follow",
                style: TextStyle(color: Colors.white, fontSize: sSp(15)),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: sHeight(20)),
          primaryBtn(onPressed: () {}, title: "Button"),
        ],
      ),
    );
  }
}

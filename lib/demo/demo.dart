import 'package:cdd_mobile_frontend/common/router/fluro_navigator.dart';
import 'package:cdd_mobile_frontend/demo/button_demo.dart';
import 'package:cdd_mobile_frontend/demo/color_demo.dart';
import 'package:cdd_mobile_frontend/demo/dialog_demo.dart';
import 'package:cdd_mobile_frontend/demo/state_demo.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    print("Demo page build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text("Jump to State Demo Page"),
              onPressed: () {
                NavigatorUtil.push(context, "/demo/state");
              },
            ),
            MaterialButton(
              child: Text("Jump to Color Demo Page"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ColorDemoPage(),
                ));
              },
            ),
            MaterialButton(
              child: Text("Jump to Button Demo Page"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ButtonDemoPage(),
                ));
              },
            ),
            MaterialButton(
              child: Text("Jump to Dialog Demo Page"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DialogDemoPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

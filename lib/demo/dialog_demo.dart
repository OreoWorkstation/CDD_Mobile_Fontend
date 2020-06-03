import 'package:cdd_mobile_frontend/common/util/screen.dart';
import 'package:cdd_mobile_frontend/common/widget/button.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';

class DialogDemoPage extends StatefulWidget {
  @override
  _DialogDemoPageState createState() => _DialogDemoPageState();
}

class _DialogDemoPageState extends State<DialogDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Demo"),
      ),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          primaryBtn(
              onPressed: () {
                print("Press button");
                _buildDialog(context);
              },
              title: "Open")
        ],
      ),
    );
  }

  Widget _buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BaseDialog(
            title: "提示",
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sWidth(16),
                vertical: sHeight(8),
              ),
              child: Text(
                "您确定要退出登录吗？",
                style: TextStyle(fontSize: sSp(16)),
              ),
            ),
            onPressed: () {
              print("Press button");
            });
      },
    );
  }
}

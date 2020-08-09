import 'package:cdd_mobile_frontend/common/net/base_state.dart';
import 'package:flutter/material.dart';

class StateDemoPage extends StatefulWidget {
  @override
  _StateDemoPageState createState() => _StateDemoPageState();
}

class _StateDemoPageState extends State<StateDemoPage> {
  BaseState _layoutState;

  @override
  void initState() {
    _layoutState = BaseState.ERROR;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("State page build");
    return Scaffold( 
      appBar: AppBar(
        title: Text("State Demo"),
      ),
      body: _listView(context),
    );
  }

  Widget _listView(BuildContext context) {
    return StateLayout(
      state: _layoutState,
      emptyRetry: () {
        setState(() {
          _layoutState = BaseState.LOADING;
        });
      },
      errorRetry: () {
        setState(() {
          _layoutState = BaseState.LOADING;
        });
        Future.delayed(Duration(seconds: 2));
      },
      successWidget: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Text("$index");
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

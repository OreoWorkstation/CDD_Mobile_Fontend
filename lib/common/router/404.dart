import 'package:flutter/material.dart';

// TODO: Need to custom this page
class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("404 page"),
      ),
      body: Center(
        child: Text("404 Not Found"),
      ),
    );
  }
}
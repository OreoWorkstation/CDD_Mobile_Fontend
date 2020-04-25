import 'package:flutter/material.dart';

class WikiPage extends StatefulWidget {
  WikiPage({Key key}) : super(key: key);

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Wiki Page"),
      ),
    );
  }
}

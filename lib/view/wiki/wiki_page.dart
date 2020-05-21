import 'package:flutter/material.dart';

class WikiPage extends StatefulWidget {
  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    print("community page build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Wiki page"),
      ),
    );
  }
}

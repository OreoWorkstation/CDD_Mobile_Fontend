import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text("相册", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Text("photo page"),
    );
  }
}

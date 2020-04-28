import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WikiPage extends StatefulWidget {
  WikiPage({Key key}) : super(key: key);

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  File _image;

  // 拍照
  Future _getImageFromCamera() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    setState(() {
      _image = image;
    });
  }

  // 从相册选择
  Future _getImageFromGalley() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _getImageFromCamera();
              },
              child: Text("照相机"),
            ),
            SizedBox(height: 10),
            RaisedButton(
                onPressed: () {
                  _getImageFromGalley();
                },
                child: Text("相册")),
            SizedBox(height: 10),
            _image == null
                ? Text("No image selected")
                : Image.file(_image, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}

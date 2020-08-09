import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoDetailPage extends StatefulWidget {
  final photoPath;
  PhotoDetailPage({Key key, this.photoPath}) : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(widget.photoPath),
      ),
    );
  }
}

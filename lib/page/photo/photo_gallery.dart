import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhtotoGalleryPage extends StatefulWidget {
  final List images;
  final int index;
  final String heroTag;
  PhtotoGalleryPage({
    Key key,
    @required this.images,
    this.index = 0,
    this.heroTag,
  }) : super(key: key);
  @override
  _PhtotoGalleryPageState createState() => _PhtotoGalleryPageState();
}

class _PhtotoGalleryPageState extends State<PhtotoGalleryPage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildPhoto(context),
          _buildBack(context),
          _buildIndex(context),
          _buildDelete(context),
        ],
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: widget.images.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              maxScale: 0.5,
              // minScale: 0.5,
              imageProvider: NetworkImage(widget.images[index]),

              // heroAttributes: widget.heroTag.isNotEmpty
              //     ? PhotoViewHeroAttributes(tag: widget.heroTag)
              //     : null,
            );
          },
          backgroundDecoration: BoxDecoration(color: Colors.black),
          pageController: _pageController,
          enableRotation: true,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // 左上角返回按钮
  Widget _buildBack(BuildContext context) {
    return Positioned(
      left: cddSetWidth(10),
      top: MediaQuery.of(context).padding.top,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: cddSetFontSize(25),
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  // 图片Index
  Widget _buildIndex(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text("${_currentIndex + 1} / ${widget.images.length}",
            style: TextStyle(
                color: Colors.white,
                fontSize: cddSetFontSize(17),
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  // 右上角删除按钮
  Widget _buildDelete(BuildContext context) {
    return Positioned(
      right: cddSetWidth(10),
      top: MediaQuery.of(context).padding.top,
      child: IconButton(
        icon: Icon(
          Iconfont.shanchu,
          size: cddSetFontSize(25),
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/page/photo/photo_detail.dart';
import 'package:cdd_mobile_frontend/page/photo/photo_gallery.dart';
import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<String> _imagePath = [
    "https://images.unsplash.com/photo-1587614313274-3e8abc873a7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1511519224480-97d30b901dc2?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1514505832027-1534ca2f576c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1066&q=80",
    "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1450778869180-41d0601e046e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2050&q=80",
    "https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=660&q=80",
    "https://images.unsplash.com/photo-1545249390-6bdfa286032f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=594&q=80",
    "https://images.unsplash.com/photo-1516386408840-d718a820a05c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1548546738-8509cb246ed3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1516366434321-728a48e6b7bf?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1587614313274-3e8abc873a7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1511519224480-97d30b901dc2?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1514505832027-1534ca2f576c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1066&q=80",
    "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1450778869180-41d0601e046e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2050&q=80",
    "https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=660&q=80",
    "https://images.unsplash.com/photo-1545249390-6bdfa286032f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=594&q=80",
    "https://images.unsplash.com/photo-1516386408840-d718a820a05c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1548546738-8509cb246ed3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1516366434321-728a48e6b7bf?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  ];
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
      body: _buildPhotoGridView(),
    );
  }

  Widget _buildPhotoGridView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: EdgeInsets.all(8),
      children: _buildGridTileList(),
    );
  }

  List<Widget> _buildGridTileList() {
    List<Widget> widgetList = [];
    for (int i = 0; i < _imagePath.length; ++i) {
      widgetList.add(GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => PhotoDetailPage(photoPath: _imagePath[i]),
          // ));
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhtotoGalleryPage(
              images: _imagePath,
              index: i,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Radii.k10pxRadius,
            image: DecorationImage(
              image: NetworkImage(_imagePath[i]),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.rectangle,
          ),
        ),
      ));
    }
    return widgetList;
  }
}

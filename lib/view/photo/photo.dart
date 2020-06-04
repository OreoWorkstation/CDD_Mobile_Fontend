import 'dart:io';

import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/photo/photo_gallery.dart';
import 'package:cdd_mobile_frontend/view_model/choose_image_provider.dart';
import 'package:cdd_mobile_frontend/view_model/photo/photo_add_provider.dart';
import 'package:cdd_mobile_frontend/view_model/photo/photo_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  String _imagePath = "";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChooseImageProvider(""),
        ),
        ChangeNotifierProvider(
          create: (_) => PhotoAddProvider(),
        ),
      ],
      child:
          Consumer3<PhotoListProvider, PhotoAddProvider, ChooseImageProvider>(
        builder:
            (_, photoListProvider, photoAddProvider, chooseImageProvider, __) {
          return Builder(
            builder: (_) {
              if (photoListProvider.isBusy) {
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              return LoadingOverlay(
                color: Colors.transparent,
                isLoading: photoAddProvider.isBusy ||
                    photoListProvider.isBusy ||
                    chooseImageProvider.isBusy,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    brightness: Brightness.light,
                    title: Text("相册", style: TextStyle(color: AppColor.dark)),
                    centerTitle: true,
                    elevation: 0.6,
                    leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: AppColor.dark),
                    ),
                    actions: <Widget>[
                      IconButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                _buildBottomSheet(context, chooseImageProvider),
                          );
                          if (chooseImageProvider.imageNetworkPath != "") {
                            await photoAddProvider.addPhoto(
                              photo: PhotoEntity(
                                petId: photoListProvider.petId,
                                photoPath: chooseImageProvider.imageNetworkPath,
                              ),
                            );
                            await photoListProvider
                                .fetchPhotoListWithoutPetId();
                          }
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColor.dark,
                        ),
                      ),
                    ],
                  ),
                  body: _buildPhotoGridView(photoListProvider),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // 打开底部选项：拍摄 / 本地相册
  _buildBottomSheet(
    BuildContext context,
    ChooseImageProvider chooseImageProvider,
  ) {
    _imagePath = chooseImageProvider.imageNetworkPath;
    return choosePhotoBottomSheetWidget(
      context: context,
      tapCamera: () async {
        await chooseImageProvider.getImageFromCamera();
        Navigator.of(context).pop();
      },
      tapGallery: () async {
        await chooseImageProvider.getImageFromGallery();
        Navigator.of(context).pop();
      },
    );
  }

  // 页面布局
  Widget _buildPhotoGridView(PhotoListProvider photoListProvider) {
    return LoadingOverlay(
      isLoading: photoListProvider.isBusy,
      color: Colors.transparent,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        padding: EdgeInsets.all(8),
        children:
            _buildGridTileList(photoListProvider.photoList, photoListProvider),
      ),
    );
  }

  // 每个相片的样式
  List<Widget> _buildGridTileList(
      List<PhotoEntity> photoList, PhotoListProvider photoListProvider) {
    List<Widget> widgetList = [];
    for (int i = 0; i < photoList.length; ++i) {
      widgetList.add(GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhtotoGalleryPage(
              photoList: photoList,
              index: i,
            ),
          ));
          photoListProvider.fetchPhotoListWithoutPetId();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Radii.k10pxRadius,
            image: DecorationImage(
              image: NetworkImage(photoList[i].photoPath),
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

/*
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

  APIResponse<String> _apiResponse;

  _handleCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // print(image.path);
    var path = await MultipartFile.fromFile(image.path);
    _apiResponse = await FileAPI.uploadImage(
      imagePath: path,
    );
    // Navigator.of(context).pop();
    setState(() {
      _imagePath.add(_apiResponse.data);
    });
  }

  _handleGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var path = await MultipartFile.fromFile(image.path);
    _apiResponse = await FileAPI.uploadImage(imagePath: path);

    setState(() {
      _imagePath.add(_apiResponse.data);
    });
  }

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
            onPressed: () => _openBottomSheet(context),
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

  // 打开底部选项：拍摄 / 本地相册
  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: cddSetHeight(250),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: cddSetHeight(10), bottom: cddSetHeight(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "选择要执行的操作",
                  style: TextStyle(
                    fontSize: cddSetFontSize(17),
                    color: AppColor.secondaryTextColor.withOpacity(0.7),
                  ),
                ),
                ListTile(
                  title: Text(
                    "拍摄",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: cddSetFontSize(17),
                    ),
                  ),
                  onTap: () => _handleCamera(context),
                ),
                ListTile(
                  title: Text("相册",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: cddSetFontSize(17),
                      )),
                  onTap: () => _handleGallery(),
                ),
                ListTile(
                  title: Text("取消",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.secondaryTextColor,
                        fontSize: cddSetFontSize(17),
                      )),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 相册布局
  Widget _buildPhotoGridView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: EdgeInsets.all(8),
      children: _buildGridTileList(),
    );
  }

  // 每个相片的样式
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
*/

import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/choose_image_provider.dart';
import 'package:cdd_mobile_frontend/view_model/feed_provider.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class InstantAddPage extends StatefulWidget {
  InstantAddPage({Key key}) : super(key: key);

  @override
  _InstantAddPageState createState() => _InstantAddPageState();
}

class _InstantAddPageState extends State<InstantAddPage> {
  TextEditingController _contentController = TextEditingController();
  String _imagePath = "";

  // 处理完成按钮
  _handleFinishButton(
    BuildContext context,
    FeedProvider provider,
  ) async {
    UserInfoEntity userInfo =
        Provider.of<UserProvider>(context, listen: false).userInfo;
    await provider.createInstant(
      instant: InstantEntity(
        userId: int.parse(Global.accessToken),
        content: _contentController.text,
        imagePath: _imagePath,
      ),
      nickname: userInfo.nickname,
      avatar: userInfo.avatar,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChooseImageProvider(""),
        ),
      ],
      child: Consumer<FeedProvider>(
        builder: (_, provider, __) {
          return LoadingOverlay(
            isLoading: provider.isBusy,
            color: Colors.transparent,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                title: Text(
                  "发布动态",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
                actions: <Widget>[
                  Consumer<FeedProvider>(
                    builder: (_, instantAddProvider, __) {
                      return textBtnFlatButtonWidget(
                        onPressed: () =>
                            _handleFinishButton(context, instantAddProvider),
                        title: "完成",
                      );
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: sHeight(20),
                    left: sWidth(10),
                    right: sWidth(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      _buildContent(),
                      SizedBox(height: sHeight(80)),
                      _buildImage(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: _contentController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          hintText: '''记录你此时的想法吧!''',
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 2),
        ),
        style: TextStyle(
          color: AppColor.primaryText,
          fontWeight: FontWeight.w400,
          fontSize: sSp(18.0),
        ),
        maxLines: null,
      ),
    );
  }

  Widget _buildImage() {
    return Consumer<ChooseImageProvider>(
      builder: (_, chooseImageProvider, __) {
        _imagePath = chooseImageProvider.imageNetworkPath;
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) =>
                  _buildChooseImageBottomSheet(chooseImageProvider),
            );
          },
          child: _imagePath == ""
              ? Container(
                  height: sHeight(200),
                  width: double.infinity,
                  child: Icon(
                    Icons.camera_alt,
                    size: sSp(50),
                  ),
                )
              : Container(
                  height: sHeight(300),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: Radii.k10pxRadius,
                    image: DecorationImage(
                      image: NetworkImage(_imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildChooseImageBottomSheet(
    ChooseImageProvider chooseImageProvider,
  ) {
    return LoadingOverlay(
      isLoading: chooseImageProvider.isBusy,
      color: Colors.transparent,
      child: choosePhotoBottomSheetWidget(
        context: context,
        tapCamera: () async {
          await chooseImageProvider.getImageFromCamera();
          Navigator.of(context).pop();
        },
        tapGallery: () async {
          await chooseImageProvider.getImageFromGallery();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

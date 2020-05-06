import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/provider/choose_image_provider.dart';
import 'package:cdd_mobile_frontend/provider/diary/diary_operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class DiaryOperationPage extends StatefulWidget {
  final int operation; // 0: 添加，1：更新
  final DiaryEntity diary;
  DiaryOperationPage({
    Key key,
    @required this.operation,
    @required this.diary,
  }) : super(key: key);

  @override
  _DiaryOperationPageState createState() => _DiaryOperationPageState();
}

class _DiaryOperationPageState extends State<DiaryOperationPage> {
  TextEditingController _contentController = TextEditingController();
  String _imagePath;
  DiaryEntity _diary;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _contentController.text = _diary.content;
    _imagePath = _diary.imagePath ?? "";
  }

  // 处理完成按钮
  _handleFinishButton(
    BuildContext context,
    DiaryOperationProvider provider,
  ) async {
    _diary.content = _contentController.text;
    _diary.imagePath = _imagePath;
    if (widget.operation == 0) {
      await provider.addDiary(diary: _diary);
    } else {
      await provider.updateDiary(diary: _diary);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DiaryOperationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChooseImageProvider(_imagePath),
        ),
      ],
      child: Consumer<DiaryOperationProvider>(
        builder: (_, provider, __) {
          if (provider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          return LoadingOverlay(
            isLoading: provider.isBusy,
            color: Colors.transparent,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                title: Text(
                  cddFormatBirthday(_diary.createTime),
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
                  textBtnFlatButtonWidget(
                    onPressed: () => _handleFinishButton(context, provider),
                    title: "完成",
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: cddSetWidth(20),
                    right: cddSetWidth(20),
                    top: cddSetHeight(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      _buildImage(context),
                      Divider(
                        height: cddSetHeight(15),
                        color: Colors.grey,
                      ),
                      _buildContent(),
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

  Widget _buildImage(BuildContext context) {
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
                  height: cddSetHeight(200),
                  width: double.infinity,
                  child: Icon(
                    Icons.camera_alt,
                    size: cddSetFontSize(50),
                  ),
                )
              : Container(
                  height: cddSetHeight(300),
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

  Widget _buildContent() {
    return Container(
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(),
      child: TextField(
        controller: _contentController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          hintText: '''记录你与宠物的美好生活''',
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(2, 10, 0, 2),
        ),
        style: TextStyle(
          color: AppColor.primaryText,
          fontWeight: FontWeight.w400,
          fontSize: cddSetFontSize(18.0),
        ),
        maxLines: null,
      ),
    );
  }
}

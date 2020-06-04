import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/choose_image_provider.dart';
import 'package:cdd_mobile_frontend/view_model/diary/diary_operation_provider.dart';
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
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return LoadingOverlay(
            isLoading: provider.isBusy,
            color: Colors.transparent,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                title: Text(
                  cddFormatBirthday(_diary.createTime),
                  style: TextStyle(
                      color: AppColor.dark, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: AppColor.dark),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.done,
                      color: AppColor.dark,
                    ),
                    onPressed: () => _handleFinishButton(context, provider),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: sWidth(20),
                    right: sWidth(20),
                    top: sHeight(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      _buildImage(context),
                      SizedBox(height: sHeight(20)),
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
                  height: sHeight(200),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
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

  Widget _buildContent() {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // height: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.white,
          ),
      child: TextField(
        controller: _contentController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          hintText: '''记录你与宠物的美好生活''',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: AppColor.lightGrey,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.fromLTRB(2, 10, 0, 2),
        ),
        style: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w500,
          fontSize: sSp(16.0),
          letterSpacing: 0.6,
        ),
        maxLines: null,
      ),
    );
  }
}

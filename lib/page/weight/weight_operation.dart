import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/provider/provider_manager.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/provider/weight/weight_operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class WeightOperation extends StatefulWidget {
  final int operation; // 0: 添加体重，1：编辑体重
  final WeightEntity weight;
  WeightOperation({
    Key key,
    @required this.operation,
    @required this.weight,
  }) : super(key: key);

  @override
  _WeightOperationState createState() => _WeightOperationState();
}

class _WeightOperationState extends State<WeightOperation> {
  // 体重值控制器
  TextEditingController _weightValueController = TextEditingController();
  // 创建时间
  DateTime _createTime;
  // 体重类
  WeightEntity _weight;

  @override
  void initState() {
    super.initState();
    _weight = widget.weight;
    if (widget.operation == 0) {
      _createTime = DateTime.now();
    } else {
      _createTime = _weight.createTime;
      _weightValueController.text = _weight.weightValue.toString();
    }
  }

  // 处理完成按钮
  _handleFinishButton(WeightOperationProvider provider) async {
    if (widget.operation == 0) {
      // 添加体重
      _weight.weightValue = double.parse(_weightValueController.text);
      _weight.createTime = _createTime;
      await provider.addWeight(weight: _weight);
    } else {
      // 更新体重
      _weight.weightValue = double.parse(_weightValueController.text);
      _weight.createTime = _createTime;
      await provider.updateWeight(weight: _weight);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeightOperationProvider(),
      child: Consumer<WeightOperationProvider>(
        builder: (_, provider, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: Text(
                widget.operation == 0 ? "添加体重" : "体重",
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
                  onPressed: () => _handleFinishButton(provider),
                  title: "完成",
                ),
              ],
            ),
            body: LoadingOverlay(
              isLoading: provider.isBusy,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(
                    left: cddSetWidth(45),
                    right: cddSetWidth(45),
                    top: cddSetHeight(50)),
                child: Column(
                  children: <Widget>[
                    _buildWeightValueInput(),
                    SizedBox(height: cddSetHeight(10)),
                    _buildCreateTime(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 体重值布局
  Widget _buildWeightValueInput() {
    return buildFormListItem(
      title: "体重",
      operation: TextField(
        controller: _weightValueController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "输入体重值",
          suffixText: "Kg",
        ),
        style: TextStyle(
          fontSize: cddSetFontSize(18),
          color: AppColor.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // 创建时间布局
  _buildCreateTime(BuildContext context) {
    return buildFormListItem(
      title: "日期",
      operation: cddDatePickerWidget(
        context: context,
        dt: _createTime,
        onConfirm: (Picker picker, List value) {
          setState(() {
            _createTime = (picker.adapter as DateTimePickerAdapter).value;
          });
        },
      ),
    );
  }
}

/*
class WeightOperation extends StatefulWidget {
  final int weightId;
  final int petId;
  final double weightValue;
  final DateTime createTime;
  final int operation; // 0: 添加体重, 1: 编辑体重

  WeightOperation({
    Key key,
    this.weightId,
    @required this.petId,
    this.weightValue,
    this.createTime,
    @required this.operation,
  }) : super(key: key);

  @override
  _WeightOperationState createState() => _WeightOperationState();
}

class _WeightOperationState extends State<WeightOperation> {
  APIResponse<bool> _apiResponse;

  TextEditingController _weightValueController = TextEditingController();

  DateTime _createTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _createTime = widget.createTime ?? DateTime.now();
    _weightValueController.text =
        widget.weightValue == null ? "" : widget.weightValue.toString();
  }

  _handleFinishButton() async {
    if (widget.operation == 0) {
      // 添加体重
      _apiResponse = await WeightAPI.insertWeight(
        weight: WeightEntity(
          petId: widget.petId,
          weightValue: double.parse(_weightValueController.text),
          createTime: _createTime,
        ),
      );
      print(_apiResponse.errorMessage ?? "Insert success");
      Navigator.of(context).pop();
    } else {
      // 更新体重
      print(_weightValueController.text);
      _apiResponse = await WeightAPI.updateWeight(
        weight: WeightEntity(
          id: widget.weightId,
          petId: widget.petId,
          weightValue: double.parse(_weightValueController.text),
          createTime: _createTime,
        ),
      );
      print(_apiResponse.errorMessage ?? "Update success");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(widget.operation == 0 ? "添加体重" : "体重",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          textBtnFlatButtonWidget(onPressed: _handleFinishButton, title: "完成"),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: cddSetWidth(45),
            right: cddSetWidth(45),
            top: cddSetHeight(50)),
        child: Column(
          children: <Widget>[
            _buildWeightValueInput(),
            SizedBox(height: cddSetHeight(10)),
            _buildCreateTime(context),
          ],
        ),
      ),
    );
  }

  _buildWeightValueInput() {
    return buildFormListItem(
      title: "体重",
      operation: TextField(
        controller: _weightValueController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "输入体重值",
          suffixText: "Kg",
        ),
        style: TextStyle(
          fontSize: cddSetFontSize(18),
          color: AppColor.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _buildCreateTime(BuildContext context) {
    return buildFormListItem(
      title: "日期",
      operation: cddDatePickerWidget(
          context: context,
          dt: _createTime,
          onConfirm: (Picker picker, List value) {
            setState(() {
              _createTime = (picker.adapter as DateTimePickerAdapter).value;
            });
          }),
    );
  }
}
*/

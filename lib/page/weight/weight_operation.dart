import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/provider/pet_provider.dart';
import 'package:cdd_mobile_frontend/provider/weight_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

class WeightOperation extends StatefulWidget {
  final int operation; // 0: 添加体重，1：编辑体重
  final int weightIndex;
  final int petId;
  WeightOperation({
    Key key,
    @required this.operation,
    this.weightIndex,
    @required this.petId,
  }) : super(key: key);

  @override
  _WeightOperationState createState() => _WeightOperationState();
}

class _WeightOperationState extends State<WeightOperation> {
  // 体重值控制器
  TextEditingController _weightValueController = TextEditingController();

  DateTime _createTime;

  @override
  void initState() {
    super.initState();
    if (widget.operation == 0) {
      _createTime = DateTime.now();
    } else {
      var weight = Provider.of<WeightProvider>(context, listen: false)
          .weightList[widget.weightIndex];
      _createTime = weight.createTime;
      _weightValueController.text = weight.weightValue.toString();
    }
  }

  // 处理完成按钮
  _handleFinishButton() async {
    var weightProvider = Provider.of<WeightProvider>(context, listen: false);
    var petProvider = Provider.of<PetProvider>(context, listen: false);
    if (widget.operation == 0) {
      // 添加体重
      await weightProvider.addWeight(
        petId: widget.petId,
        weightValue: double.parse(_weightValueController.text),
        createTime: _createTime,
      );
    } else {
      // 更新体重
      await weightProvider.updateWeight(
        weightIndex: widget.weightIndex,
        weightValue: double.parse(_weightValueController.text),
        createTime: _createTime,
      );
    }
    await petProvider.fetchPetList();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: _handleFinishButton,
            title: "完成",
          ),
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

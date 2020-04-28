import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/list.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class CostOperation extends StatefulWidget {
  final int costId;
  final int petId;
  final double costValue;
  final String costContent;
  final DateTime createTime;
  final int operation;

  CostOperation({
    Key key,
    this.costId,
    @required this.petId,
    this.costValue,
    this.costContent,
    this.createTime,
    @required this.operation,
  }) : super(key: key);

  @override
  _CostOperationState createState() => _CostOperationState();
}

class _CostOperationState extends State<CostOperation> {
  List<String> _tags = [
    "衣服",
    "食物",
    "玩具",
    "医疗",
    "其他",
  ];

  List<Color> _colors = [
    Color.fromARGB(255, 241, 137, 238),
    Color.fromARGB(255, 154, 137, 241),
    Color.fromARGB(255, 246, 110, 95),
    Color.fromARGB(255, 137, 207, 241),
    Color.fromARGB(255, 0, 200, 12),
  ];

  List<IconData> _icons = [
    Iconfont.yifu,
    Iconfont.gouliang,
    Iconfont.wanju,
    Iconfont.yiliao,
    Iconfont.qita,
  ];

  List<String> _selected = [];
  APIResponse<bool> _apiResponse;

  TextEditingController _costValueController = TextEditingController();

  DateTime _createTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _costValueController.text =
        widget.costValue == null ? "" : widget.costValue.toString();
    _createTime = widget.createTime ?? DateTime.now();
    _selected = widget.costContent == null
        ? []
        : cddConvertString2List(widget.costContent);
  }

  _handleFinishButton(BuildContext context) async {
    if (widget.operation == 0) {
      _apiResponse = await CostAPI.insertCost(
        cost: CostEntity(
          petId: widget.petId,
          costValue: double.parse(_costValueController.text),
          costContent: _selected.toString(),
          createTime: _createTime,
        ),
      );
      print(_apiResponse.errorMessage ?? "Insert success");
      Navigator.of(context).pop();
    } else {
      _apiResponse = await CostAPI.updateCost(
        cost: CostEntity(
          id: widget.costId,
          petId: widget.petId,
          costValue: double.parse(_costValueController.text),
          costContent: _selected.toString(),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          widget.operation == 0 ? "添加消费" : "消费",
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
              onPressed: () => _handleFinishButton(context), title: "完成"),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: cddSetWidth(45),
          right: cddSetWidth(45),
          top: cddSetHeight(45),
        ),
        child: Column(
          children: <Widget>[
            _buildCostValueInput(),
            SizedBox(height: cddSetHeight(15)),
            _buildCostContentChoose(),
            SizedBox(height: cddSetHeight(15)),
            _buildCreateTime(),
          ],
        ),
      ),
    );
  }

  // 构建输入消费金额输入框
  Widget _buildCostValueInput() {
    return buildFormListItem(
      title: "消费金额",
      operation: TextField(
        controller: _costValueController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "输入消费金额",
          prefixText: "￥",
        ),
        style: TextStyle(
          fontSize: cddSetFontSize(18),
          color: AppColor.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCostContentChoose() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Text(
            "消费内容",
            style: TextStyle(
              color: AppColor.primaryText.withOpacity(0.8),
              fontSize: cddSetFontSize(17),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: cddSetHeight(10)),
        Wrap(
          spacing: 30.0,
          children: <Widget>[
            _buildChip(0),
            _buildChip(1),
            _buildChip(2),
            _buildChip(3),
            _buildChip(4),
          ],
        ),
      ],
    );
  }

  Widget _buildCreateTime() {
    return buildFormListItem(
      title: "日期",
      operation: cddDatePickerWidget(
        context: context,
        dt: _createTime,
        onConfirm: (Picker picker, List value) {
          setState(
            () {
              _createTime = (picker.adapter as DateTimePickerAdapter).value;
            },
          );
        },
      ),
    );
  }

  Widget _buildChip(int index) {
    return FilterChip(
      label: Text(
        _tags[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: cddSetFontSize(14),
          fontWeight: FontWeight.w600,
        ),
      ),
      disabledColor: AppColor.primaryText,
      selectedColor: _colors[index],
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          _icons[index],
          color: Colors.white,
          size: cddSetFontSize(17),
        ),
      ),
      selected: _selected.contains(_tags[index]),
      onSelected: (val) {
        setState(() {
          if (_selected.contains(_tags[index])) {
            _selected.remove(_tags[index]);
          } else {
            _selected.add(_tags[index]);
          }
        });
      },
    );
  }
}

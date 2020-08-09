import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/date_picker.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view_model/cost/cost_operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class CostOperation extends StatefulWidget {
  final int operation; // 0: 添加消费，1：编辑消费
  final CostEntity cost;

  CostOperation({
    Key key,
    @required this.operation,
    @required this.cost,
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

  // 消费内容
  List<String> _selected = [];
  // 消费值控制器
  TextEditingController _costValueController = TextEditingController();
  // 消费时间
  DateTime _createTime = DateTime.now();
  // 消费类
  CostEntity _cost;

  @override
  void initState() {
    super.initState();
    _cost = widget.cost;
    if (widget.operation == 0) {
      _createTime = DateTime.now();
    } else {
      _createTime = _cost.createTime;
      _costValueController.text = _cost.costValue.toString();
      _selected = _cost.costContent == null
          ? []
          : cddConvertString2List(_cost.costContent);
    }
  }

  // 处理完成按钮
  _handleFinishButton(
    BuildContext context,
    CostOperationProvider provider,
  ) async {
    _cost.costValue = double.parse(_costValueController.text);
    _cost.costContent = _selected.toString();
    _cost.createTime = _createTime;
    if (widget.operation == 0) {
      // 添加消费
      await provider.addCost(cost: _cost);
    } else {
      // 更新消费
      await provider.updateCost(cost: _cost);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CostOperationProvider(),
      child: Consumer<CostOperationProvider>(
        builder: (_, provider, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: Text(
                widget.operation == 0 ? "添加消费" : "消费",
                style: TextStyle(color: AppColor.dark),
              ),
              centerTitle: true,
              elevation: 0.6,
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
            body: LoadingOverlay(
              isLoading: provider.isBusy,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: sHeight(10),
                  horizontal: sWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    _buildCostValueInput(),
                    SizedBox(height: sHeight(15)),
                    _buildCostContentChoose(),
                    SizedBox(height: sHeight(15)),
                    _buildCreateTime(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 消费值布局
  Widget _buildCostValueInput() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: sWidth(15), vertical: sHeight(5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: buildFormListItem(
        title: "消费金额",
        operation: TextField(
          controller: _costValueController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "输入消费金额",
            prefixText: "￥",
            hintStyle: TextStyle(
              color: AppColor.lightGrey,
              fontSize: sSp(16),
              fontWeight: FontWeight.w500,
            ),
            prefixStyle: TextStyle(
              color: AppColor.grey,
              fontSize: sSp(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          style: TextStyle(
            fontSize: sSp(16),
            color: AppColor.dark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 消费内容布局
  Widget _buildCostContentChoose() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: sWidth(15), vertical: sHeight(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              "消费内容",
              style: TextStyle(
                color: AppColor.dark.withOpacity(.7),
                fontSize: sSp(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: sHeight(10)),
          Wrap(
            spacing: sWidth(30),
            children: <Widget>[
              _buildChip(0),
              _buildChip(1),
              _buildChip(2),
              _buildChip(3),
              _buildChip(4),
            ],
          ),
        ],
      ),
    );
  }

  // 消费时间布局
  Widget _buildCreateTime() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sWidth(15),
        vertical: sHeight(15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: buildFormListItem(
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
      ),
    );
  }

  // 消费选项布局
  Widget _buildChip(int index) {
    return FilterChip(
      label: Text(
        _tags[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: sSp(14),
          fontWeight: FontWeight.w600,
        ),
      ),
      disabledColor: AppColor.grey,
      selectedColor: _colors[index].withOpacity(.6),
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          _icons[index],
          color: Colors.white,
          size: sSp(16),
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
/*
class CostOperation extends StatefulWidget {
  final int operation; // 0: 添加消费，1：编辑消费
  final CostEntity cost;

  CostOperation({
    Key key,
    @required this.operation,
    @required this.cost,
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
          left: sWidth(45),
          right: sWidth(45),
          top: sHeight(45),
        ),
        child: Column(
          children: <Widget>[
            _buildCostValueInput(),
            SizedBox(height: sHeight(15)),
            _buildCostContentChoose(),
            SizedBox(height: sHeight(15)),
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
          fontSize: sSp(18),
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
              fontSize: sSp(17),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: sHeight(10)),
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
          fontSize: sSp(14),
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
          size: sSp(17),
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
*/

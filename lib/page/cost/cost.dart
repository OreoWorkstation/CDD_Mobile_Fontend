import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/chart.dart';
import 'package:cdd_mobile_frontend/common/widget/dialog.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/page/cost/cost_operation.dart';
import 'package:flutter/material.dart';

List itemColors = [
  Color.fromARGB(255, 50, 245, 141),
  Color.fromARGB(255, 255, 175, 137),
  Color.fromARGB(255, 147, 118, 246),
  Color.fromARGB(255, 240, 92, 106),
  Color.fromARGB(255, 235, 240, 105),
];

class CostPage extends StatefulWidget {
  final petId;
  CostPage({Key key, @required this.petId}) : super(key: key);

  @override
  _CostPageState createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  APIResponse<List<CostEntity>> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCostList();
  }

  _fetchCostList() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await CostAPI.getCostList(petId: widget.petId);
    setState(() {
      _isLoading = false;
    });
  }

  _handleTapCost(BuildContext context, int index) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CostOperation(
          operation: 1,
          costId: _apiResponse.data[index].id,
          petId: widget.petId,
          costContent: _apiResponse.data[index].costContent,
          costValue: _apiResponse.data[index].costValue,
          createTime: _apiResponse.data[index].createTime,
        ),
      ),
    );
    _fetchCostList();
  }

  _handleAddCost(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CostOperation(
        operation: 0,
        petId: widget.petId,
      ),
    ));
    _fetchCostList();
  }

  Future<bool> _handleDeleteCost(BuildContext context, int index) async {
    bool isDismiss = false;
    isDismiss = await showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmDialog("确定删除该消费信息吗?", () async {
          await CostAPI.deleteCost(costId: _apiResponse.data[index].id);
          Navigator.of(context).pop(true);
        });
      },
    );
    return isDismiss;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: Text("消费", style: TextStyle(color: Colors.black)),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: cddSetWidth(23)),
              child: Column(
                children: <Widget>[
                  _buildChart(),
                  _buildList(context),
                  _buildBottomButton(context),
                ],
              ),
            ),
          );
  }

  // 构建曲线图
  _buildChart() {
    List<LineSales> dataLine = _apiResponse.data.length == 0
        ? []
        : _apiResponse.data.map((item) {
            return LineSales(item.createTime, item.costValue);
          }).toList();
    return Container(
      margin: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      width: double.infinity,
      height: cddSetHeight(210),
      child: cddLineChart(dataLine),
    );
  }

  // 构建List
  _buildList(BuildContext context) {
    return Expanded(
      child: Container(
        child: _apiResponse.data.length == 0
            ? Center(child: Text("none"))
            : ListView.builder(
                itemBuilder: (context, index) {
                  return _buildListItem(context, index);
                },
                itemCount: _apiResponse.data.length,
              ),
      ),
    );
  }

  _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _handleTapCost(context, index),
      child: Dismissible(
        key: Key(_apiResponse.data.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return _handleDeleteCost(context, index);
        },
        onDismissed: (directrion) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "删除成功!",
                style: TextStyle(
                  color: AppColor.primaryElement,
                  fontSize: cddSetFontSize(17),
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 2,
            ),
          );
          _fetchCostList();
        },
        background: Container(color: itemColors[index]),
        child: Container(
          width: double.infinity,
          height: cddSetHeight(60),
          margin: EdgeInsets.symmetric(vertical: cddSetHeight(10)),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 5),
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: cddSetWidth(11),
                height: double.infinity,
                color: itemColors[index % itemColors.length],
              ),
              SizedBox(width: cddSetWidth(12)),
              Icon(Iconfont.zhangdan, color: AppColor.secondaryElement),
              SizedBox(width: cddSetWidth(19)),
              Text(
                cddFormatBirthday(_apiResponse.data[index].createTime),
                style: TextStyle(
                    fontSize: cddSetFontSize(16),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "￥${_apiResponse.data[index].costValue}",
                style: TextStyle(
                  fontSize: cddSetFontSize(16),
                  color: Color.fromARGB(255, 75, 3, 242),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: cddSetWidth(20)),
            ],
          ),
        ),
      ),
    );
  }

  // 构建底部按钮
  _buildBottomButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      child: btnFlatButtonWidget(
        onPressed: () => _handleAddCost(context),
        bgColor: AppColor.costColor,
        width: cddSetWidth(250),
        height: cddSetHeight(48),
        title: "添加",
        fontSize: cddSetFontSize(14),
      ),
    );
  }
}

import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/chart.dart';
import 'package:cdd_mobile_frontend/common/widget/dialog.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/page/weight/weight_operation.dart';
import 'package:flutter/material.dart';

List itemColors = [
  Color.fromARGB(255, 50, 245, 141),
  Color.fromARGB(255, 255, 175, 137),
  Color.fromARGB(255, 147, 118, 246),
  Color.fromARGB(255, 240, 92, 106),
  Color.fromARGB(255, 235, 240, 105),
];

class WeightPage extends StatefulWidget {
  final petId;
  WeightPage({Key key, this.petId}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  APIResponse<List<WeightEntity>> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _fetchWeightList();
  }

  _fetchWeightList() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await WeightAPI.getWeightList(petId: widget.petId);
    setState(() {
      _isLoading = false;
    });
  }

  // 处理添加体重信息
  _handleAddWeight(context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeightOperation(
          operation: 0,
          petId: widget.petId,
        ),
      ),
    );
    _fetchWeightList();
  }

  _handleTapWeight(BuildContext context, int index) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeightOperation(
          operation: 2,
          petId: widget.petId,
          weightId: _apiResponse.data[index].id,
          weightValue: _apiResponse.data[index].weightValue,
          createTime: _apiResponse.data[index].createTime,
        ),
      ),
    );
    _fetchWeightList();
  }

  Future<bool> _handleDeleteWeight(BuildContext context, int index) async {
    bool isDismiss = false;
    isDismiss = await showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmDialog("确定删除该体重信息吗?", () async {
          await WeightAPI.deleteWeight(weightId: _apiResponse.data[index].id);
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
              title: Text("体重", style: TextStyle(color: Colors.black)),
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
                  _buildList(),
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
            return LineSales(item.createTime, item.weightValue);
          }).toList();
    return Container(
      margin: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      width: double.infinity,
      height: cddSetHeight(210),
      child: cddLineChart(dataLine),
    );
  }

  // 构建List
  _buildList() {
    return Expanded(
      child: Container(
        child: _apiResponse.data.length == 0
            ? Text("none")
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
        onTap: () => _handleTapWeight(context, index),
        child: Dismissible(
          key: Key(_apiResponse.data.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            return _handleDeleteWeight(context, index);
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
            _fetchWeightList();
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
                Icon(Iconfont.weight, color: AppColor.secondaryElement),
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
                  "${_apiResponse.data[index].weightValue} Kg",
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
        ));
  }

  // 构建底部按钮
  _buildBottomButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      child: btnFlatButtonWidget(
        onPressed: () => _handleAddWeight(context),
        bgColor: AppColor.weightColor,
        width: cddSetWidth(250),
        height: cddSetHeight(48),
        title: "添加",
        fontSize: cddSetFontSize(14),
      ),
    );
  }
}

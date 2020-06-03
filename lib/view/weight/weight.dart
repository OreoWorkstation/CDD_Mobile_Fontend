import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/chart.dart';
import 'package:cdd_mobile_frontend/common/widget/dialog.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/weight/weight_operation.dart';
import 'package:cdd_mobile_frontend/view_model/weight/weight_delete_provider.dart';
import 'package:cdd_mobile_frontend/view_model/weight/weight_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class WeightPage extends StatefulWidget {
  WeightPage({Key key}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  // 处理添加体重信息
  _handleAddWeight(
    BuildContext context,
    WeightListProvider weightListProvider,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeightOperation(
          operation: 0,
          weight: WeightEntity(petId: weightListProvider.petId),
        ),
      ),
    );
    weightListProvider.fetchWeightListWithoutPetId();
  }

  // 处理删除体重信息
  Future<bool> _handleDeleteWeight(
    BuildContext context,
    int weightId,
  ) async {
    bool isDismiss = false;
    isDismiss = await showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => WeightDeleteProvider(),
          child: Consumer<WeightDeleteProvider>(
            builder: (_, weightDeleteProvider, __) {
              return LoadingOverlay(
                isLoading: weightDeleteProvider.isBusy,
                color: Colors.transparent,
                child: DeleteConfirmDialog(
                  "确定删除该体重信息吗?",
                  () async {
                    await weightDeleteProvider.deleteWeight(weightId: weightId);
                    Navigator.of(context).pop(true);
                  },
                ),
              );
            },
          ),
        );
      },
    );
    return isDismiss;
  }

  // 处理点击体重项（查看体重信息）
  _handleTapWeight(
    BuildContext context,
    WeightEntity weight,
    WeightListProvider weightListProvider,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeightOperation(
          operation: 1,
          weight: weight,
        ),
      ),
    );
    weightListProvider.fetchWeightListWithoutPetId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Consumer<WeightListProvider>(
        builder: (context, weightListProvider, child) => Builder(
          builder: (_) {
            // 正在请求
            if (weightListProvider == null || weightListProvider.isBusy) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: sWidth(23)),
              child: Column(
                children: <Widget>[
                  // 曲线图表
                  _buildChart(weightListProvider.weightList),
                  // 体重列表
                  _buildWeightList(context, weightListProvider),
                  // 添加按钮
                  _buildBottomButton(context, weightListProvider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 曲线图表布局
  Widget _buildChart(List<WeightEntity> weightList) {
    List<LineSales> dataLine = weightList.length == 0
        ? []
        : weightList.map((item) {
            return LineSales(item.createTime, item.weightValue);
          }).toList();
    return Container(
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      width: double.infinity,
      height: sHeight(210),
      child: cddLineChart(dataLine),
    );
  }

  // 体重列表布局
  Widget _buildWeightList(
    BuildContext context,
    WeightListProvider weightListProvider,
  ) {
    var weightList = weightListProvider.weightList;
    return Expanded(
      child: Container(
        child: weightList.length == 0
            ? Text("none")
            : ListView.builder(
                itemBuilder: (context, index) {
                  return _buildWeightListItem(
                    context,
                    index,
                    weightListProvider,
                  );
                },
                itemCount: weightList.length,
              ),
      ),
    );
  }

  // 体重列表项布局
  Widget _buildWeightListItem(
    BuildContext context,
    int index,
    WeightListProvider weightListProvider,
  ) {
    var weight = weightListProvider.weightList[index];
    return GestureDetector(
      // 点击体重项
      onTap: () => _handleTapWeight(context, weight, weightListProvider),
      // 删除体重项
      child: Dismissible(
        key: Key(weightListProvider.weightList.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return _handleDeleteWeight(context, weight.id);
        },
        onDismissed: (directrion) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "删除成功!",
                style: TextStyle(
                  color: AppColor.primaryElement,
                  fontSize: sSp(17),
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 2,
            ),
          );
          weightListProvider.fetchWeightListWithoutPetId();
        },
        background: Container(color: AppColor.listItemColors[index]),
        child: Container(
          width: double.infinity,
          height: sHeight(60),
          margin: EdgeInsets.symmetric(vertical: sHeight(10)),
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
                width: sWidth(11),
                height: double.infinity,
                color: AppColor
                    .listItemColors[index % AppColor.listItemColors.length],
              ),
              SizedBox(width: sWidth(12)),
              Icon(Iconfont.weight, color: AppColor.secondaryElement),
              SizedBox(width: sWidth(19)),
              Text(
                cddFormatBirthday(weight.createTime),
                style: TextStyle(
                    fontSize: sSp(16),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "${weight.weightValue} Kg",
                style: TextStyle(
                  fontSize: sSp(16),
                  color: Color.fromARGB(255, 75, 3, 242),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: sWidth(20)),
            ],
          ),
        ),
      ),
    );
  }

  // 底部按钮布局
  _buildBottomButton(
    BuildContext context,
    WeightListProvider weightListProvider,
  ) {
    return Container(
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: primaryBtn(
        onPressed: () => _handleAddWeight(context, weightListProvider),
        bgColor: AppColor.testBlueColor1,
        width: sWidth(250),
        height: sHeight(48),
        title: "添加",
        fontSize: sSp(14),
      ),
    );
  }
}
/*
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
              padding: EdgeInsets.symmetric(horizontal: sWidth(23)),
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
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      width: double.infinity,
      height: sHeight(210),
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
                    fontSize: sSp(17),
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
            height: sHeight(60),
            margin: EdgeInsets.symmetric(vertical: sHeight(10)),
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
                  width: sWidth(11),
                  height: double.infinity,
                  color: itemColors[index % itemColors.length],
                ),
                SizedBox(width: sWidth(12)),
                Icon(Iconfont.weight, color: AppColor.secondaryElement),
                SizedBox(width: sWidth(19)),
                Text(
                  cddFormatBirthday(_apiResponse.data[index].createTime),
                  style: TextStyle(
                      fontSize: sSp(16),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "${_apiResponse.data[index].weightValue} Kg",
                  style: TextStyle(
                    fontSize: sSp(16),
                    color: Color.fromARGB(255, 75, 3, 242),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: sWidth(20)),
              ],
            ),
          ),
        ));
  }

  // 构建底部按钮
  _buildBottomButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: btnFlatButtonWidget(
        onPressed: () => _handleAddWeight(context),
        bgColor: AppColor.weightColor,
        width: sWidth(250),
        height: sHeight(48),
        title: "添加",
        fontSize: sSp(14),
      ),
    );
  }
}

*/

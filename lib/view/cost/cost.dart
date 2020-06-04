import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/dialog.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/model/entity.dart';
import 'package:cdd_mobile_frontend/view/cost/cost_operation.dart';
import 'package:cdd_mobile_frontend/view_model/cost/cost_delete_provider.dart';
import 'package:cdd_mobile_frontend/view_model/cost/cost_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class CostPage extends StatefulWidget {
  CostPage({Key key}) : super(key: key);

  @override
  _CostPageState createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  // 处理添加消费信息
  _handleAddCost(
    BuildContext context,
    CostListProvider costListProvider,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CostOperation(
          operation: 0,
          cost: CostEntity(petId: costListProvider.petId),
        ),
      ),
    );
    costListProvider.fetchCostListWithoutPetId();
  }

  // 处理删除消费信息
  Future<bool> _handleDeleteCost(
    BuildContext context,
    int costId,
  ) async {
    bool isDismiss = false;
    isDismiss = await showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => CostDeleteProvider(),
          child: Consumer<CostDeleteProvider>(
            builder: (_, costDeleteProvider, __) {
              return LoadingOverlay(
                isLoading: costDeleteProvider.isBusy,
                color: Colors.transparent,
                child: DeleteConfirmDialog(
                  "确定删除该消费信息吗?",
                  () async {
                    await costDeleteProvider.deleteCost(costId: costId);
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

  // 处理点击消费项（查看并可以更新消费信息）
  _handleTapCost(
    BuildContext context,
    CostEntity cost,
    CostListProvider costListProvider,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CostOperation(
          operation: 1,
          cost: cost,
        ),
      ),
    );
    costListProvider.fetchCostListWithoutPetId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text("消费",
            style: TextStyle(
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
        elevation: 0.6,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: AppColor.dark),
        ),
        actions: <Widget>[
          Consumer<CostListProvider>(
            builder: (_, provider, __) {
              return IconButton(
                icon: Icon(
                  Icons.add,
                  color: AppColor.dark,
                ),
                onPressed: () => _handleAddCost(context, provider),
              );
            },
          ),
        ],
      ),
      body: Consumer<CostListProvider>(
        builder: (_, costListProvider, __) {
          // 正在请求
          if (costListProvider == null || costListProvider.isBusy) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: sWidth(20)),
            child: Column(
              children: <Widget>[
                // 曲线图表
                _buildChart(costListProvider.costList),
                // 消费列表
                _buildCostList(context, costListProvider),
                // 添加按钮
                // _buildBottomButton(context, costListProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  // 曲线图表布局
  Widget _buildChart(List<CostEntity> costList) {
    List<LineSales> dataLine = costList.length == 0
        ? []
        : costList.map((item) {
            return LineSales(item.createTime, item.costValue);
          }).toList();
    return Container(
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      padding: EdgeInsets.symmetric(
        horizontal: sWidth(10),
        vertical: sHeight(15),
      ),
      width: double.infinity,
      height: sHeight(220),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, 0),
              color: Colors.grey.withOpacity(.1),
            ),
          ]),
      child: cddLineChart(dataLine),
    );
  }

  // 消费列表布局
  Widget _buildCostList(
    BuildContext context,
    CostListProvider costListProvider,
  ) {
    var costList = costListProvider.costList;
    return Expanded(
      child: Container(
        child: costList.length == 0
            ? Center(child: Text("none"))
            : ListView.builder(
                itemBuilder: (context, index) {
                  return _buildListItem(
                    context,
                    index,
                    costListProvider,
                  );
                },
                itemCount: costList.length,
              ),
      ),
    );
  }

  // 消费列表项布局
  Widget _buildListItem(
    BuildContext context,
    int index,
    CostListProvider costListProvider,
  ) {
    var cost = costListProvider.costList[index];
    return GestureDetector(
      // 点击消费项
      onTap: () => _handleTapCost(context, cost, costListProvider),
      // 删除消费项
      child: Dismissible(
        key: Key(costListProvider.costList.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return _handleDeleteCost(context, cost.id);
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
          costListProvider.fetchCostListWithoutPetId();
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
                color: Colors.grey.withOpacity(.1),
                offset: Offset(0, 0),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: sWidth(10),
                height: double.infinity,
                color: AppColor
                    .listItemColors[index % AppColor.listItemColors.length],
              ),
              SizedBox(width: sWidth(12)),
              Icon(Iconfont.zhangdan, color: AppColor.grey),
              SizedBox(width: sWidth(20)),
              Text(
                cddFormatBirthday(cost.createTime),
                style: TextStyle(
                  fontSize: sSp(16),
                  color: AppColor.dark,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
              Spacer(),
              Text(
                "￥${cost.costValue}",
                style: TextStyle(
                  fontSize: sSp(16),
                  color: AppColor.primary,
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
  Widget _buildBottomButton(
    BuildContext context,
    CostListProvider costListProvider,
  ) {
    return Container(
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: primaryBtn(
        onPressed: () => _handleAddCost(context, costListProvider),
        bgColor: AppColor.costColor,
        width: sWidth(250),
        height: sHeight(48),
        title: "添加",
        fontSize: sSp(14),
      ),
    );
  }
}

/*
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
              padding: EdgeInsets.symmetric(horizontal: sWidth(23)),
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
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      width: double.infinity,
      height: sHeight(210),
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
                  fontSize: sSp(17),
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
              Icon(Iconfont.zhangdan, color: AppColor.secondaryElement),
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
                "￥${_apiResponse.data[index].costValue}",
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

  // 构建底部按钮
  _buildBottomButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: sHeight(10), bottom: sHeight(10)),
      child: btnFlatButtonWidget(
        onPressed: () => _handleAddCost(context),
        bgColor: AppColor.costColor,
        width: sWidth(250),
        height: sHeight(48),
        title: "添加",
        fontSize: sSp(14),
      ),
    );
  }
}
*/

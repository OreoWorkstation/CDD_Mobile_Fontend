import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';

List itemColors = [
  Color.fromARGB(255, 50, 245, 141),
  Color.fromARGB(255, 255, 175, 137),
  Color.fromARGB(255, 147, 118, 246),
  Color.fromARGB(255, 240, 92, 106),
  Color.fromARGB(255, 235, 240, 105),
];

class CostPage extends StatefulWidget {
  CostPage({Key key}) : super(key: key);

  @override
  _CostPageState createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _buildList(),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  // 构建曲线图
  _buildChart() {
    return Container(
      margin: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      width: double.infinity,
      height: cddSetHeight(210),
      color: Colors.black,
    );
  }

  // 构建List
  _buildList() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildListItem(index);
          },
          itemCount: 10,
        ),
      ),
    );
  }

  _buildListItem(int index) {
    return GestureDetector(
        onTap: () {
          print("tap item");
        },
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
                "2020-04-23",
                style: TextStyle(
                    fontSize: cddSetFontSize(16),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "￥34",
                style: TextStyle(
                  fontSize: cddSetFontSize(16),
                  color: Color.fromARGB(255, 75, 3, 242),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: cddSetWidth(20)),
            ],
          ),
        ));
  }

  // 构建底部按钮
  _buildBottomButton() {
    return Container(
      margin: EdgeInsets.only(top: cddSetHeight(10), bottom: cddSetHeight(10)),
      child: btnFlatButtonWidget(
        onPressed: () {},
        bgColor: AppColor.costColor,
        width: cddSetWidth(250),
        height: cddSetHeight(48),
        title: "添加",
        fontSize: cddSetFontSize(14),
      ),
    );
  }
}

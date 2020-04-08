import 'package:cdd_mobile_frontend/view/page/pet/bill/bill_page.dart';
import 'package:cdd_mobile_frontend/view/page/pet/diary/diary_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'weight/weight_page.dart';

class PetOverviewPage extends StatefulWidget {
  final String name;
  PetOverviewPage({Key key, this.name}) : super(key: key);
  @override
  _PetOverviewPageState createState() => _PetOverviewPageState();
}

class _PetOverviewPageState extends State<PetOverviewPage> {
  // TODO: For change image in the future
  List<LinearGradient> _colors = [
    LinearGradient(
      colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [Colors.blue, Colors.green],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];

  double _backgroundHeight = 280;

  @override
  Widget build(BuildContext context) {
    print("name: ${widget.name}");
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  print("Tap");
                  setState(() {
                    _colors.insert(0, _colors.removeLast());
                  });
                },
                child: Container(
                  height: _backgroundHeight,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: _colors[0],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop("This is something");
                        },
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("提示"),
                              content: Text("这是设置按钮"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('确认'),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: _backgroundHeight - 35,
                  left: 60,
                ),
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                height: 70,
                width: 290,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // TODO: need change name
                    Text(
                      "Pet Name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Introduction",
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: _backgroundHeight - 50,
                  left: MediaQuery.of(context).size.width - 75 - 60,
                ),
                height: 75,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "H",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GridDashboard(),
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  const GridDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        staggeredTiles: <StaggeredTile>[
          StaggeredTile.count(1, 0.5),
          StaggeredTile.count(1, 0.5),
          StaggeredTile.count(1, 0.5),
          StaggeredTile.count(1, 0.5),
          StaggeredTile.count(2, 1),
        ],
        children: <Widget>[
          _creatGirdItem(Colors.pinkAccent, "体重", "32kg", () {
            //TODO 2020.4.7.zth need to change the [parameter of function]
            print("Tab Weight");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WeightPage(name: "pet_name"),
              ),
            );
          }),
          _creatGirdItem(Colors.redAccent, "日记", "20", () {
            print("Tab diary");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DiaryPage(),
              ),
            );
          }),
          _creatGirdItem(Colors.orangeAccent, "总消费", "￥230", () {
            print("Tab cost");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BillPage(name: "pet_name"),
              ),
            );
          }),
          _creatGirdItem(Colors.purpleAccent, "铲屎官", "2", () {
            print("Tab person");
          }),
          _creatGirdItem(Colors.amberAccent, "相册", "相册列表", () {
            print("Tab photo");
          }),
        ],
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

GestureDetector _creatGirdItem(
    Color _color, String _title, String _data, Function _tapEvent) {
  return GestureDetector(
    onTap: _tapEvent,
    child: Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: _color,
            blurRadius: 2.0,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  _title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _data,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

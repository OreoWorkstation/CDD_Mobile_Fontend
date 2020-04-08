import 'package:cdd_mobile_frontend/view/page/pet/pet_borad_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'pet_overview_page.dart';

var pets = [
  {'name': '土师', 'type': '狗', 'age': 5, 'description': 'golden dog'},
  {'name': '唐共力', 'type': '狗', 'age': 5, 'description': 'golden dog'},
  {'name': '我不是狗', 'type': '猫', 'age': 2, 'description': 'golden cat'},
  {'name': 'A', 'type': '猫', 'age': 2, 'description': 'golden cat'},
  {'name': 'B', 'type': '狗', 'age': 3, 'description': 'stupid dog'}
];

class PetPage extends StatefulWidget {
  var pet_num = 0;
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width; //360
    var h = MediaQuery.of(context).size.height;  //780
//    print(w);
//    print(h);
    return Stack(
      children: <Widget>[
        Container(                                                              //AppBar + Background
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue[300], Colors.blueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("猫狗日记",
                style: TextStyle(
                  color: Colors.black,
                )),
            leading: Builder(builder: (BuildContext context) {                  //设置Drawer Icon的颜色
              return IconButton(
                icon: const Icon(Icons.list, color: Colors.black),
                onPressed: () {
                  //TODO 2020.3.4.zth midify [drawer]
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.black),             //导航栏右侧菜单
                  onPressed: () {
                    print("you pressed iconbutton");
                  }),
            ],
          ),
        ),
        Container(                                                              //上方显示宠物数量Text
          padding: EdgeInsets.only(top: h/7, left: w/20),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "已经拥有宠物",
              style: TextStyle(color: Colors.white, fontSize: w/9),
            ),
            TextSpan(
              text: "${widget.pet_num}",
              style: TextStyle(
                  color: Colors.white70, fontFamily: 'italic', fontSize: w/9),
            ),
            TextSpan(
              text: "只",
              style: TextStyle(color: Colors.white, fontSize: w/9),
            ),
          ])),
        ),
        ConstrainedBox(                                                         //下方白色框
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: double.infinity,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: h/3.5),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.elliptical(w/7, w/7)),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: double.infinity,
                  ),
                  child: Container(
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(                                         //“宠物  + 号按钮”
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: w/12, top: h/39),
                                  child: Text("宠物",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "Courier",
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w/3.6, top: h/39),
                                  child: OutlineButton.icon(onPressed: _AddPet,
                                    icon: Icon(Icons.add),
                                    label: Text("添加我的宠物",style: TextStyle(fontSize: h/50),),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 8,
                            child: Center(                                      //下方Swiper
                              child: SizedBox(
                                width: double.infinity,
                                height: h/2,
                                //child:redBox,
                                child: widget.pet_num == 0                      // num == 0 显示FloatingButton 否则显示Swiper
                                    ? Center(
                                    child: FloatingActionButton(
                                      child: Icon(Icons.add, size: h/15.5),
                                      onPressed: _AddPet,
                                    ))
                                    : Swiper(
                                  scale: 0.9,
                                  viewportFraction: 0.8,
                                  //TODO 2020.4.3.zth add data communication with [pet_board]
                                  itemBuilder: (BuildContext context, int index) => PetBoard(index: index),    //Pet Board
                                  itemCount: widget.pet_num,
                                  scrollDirection: Axis.horizontal,
                                  loop: false,
                                  //duration: 3000,
                                  autoplay: false,
                                  onIndexChanged: (index) {
                                    print("$index");
                                    debugPrint("index:$index");
                                  },
                                  onTap: (index) async {
                                    //TODO 2020.3.4.zth modify function to [open new pet page]
                                    var nowname = (pets[index])['name'];
                                    debugPrint("点击了第:$index个 它叫$nowname");
                                    final result = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PetOverviewPage(name: "HHHHH"),
                                      ),
                                    );
                                    print(result);
                                  },
                                  pagination: SwiperPagination(
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(bottom: h/78),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      )),
                )),
          ),
        )
      ],
    );
  }

  void _AddPet() {
    //TODO 2020.3.4.zth add data communication with server [add pet]
    setState(() {
      if (widget.pet_num == 5) {
        showDialog(
            context: context,
            builder: (context) {                                                //提示以达到上限
              return new AlertDialog(
                title: new Text("提示"),
                content: new Text("非常抱歉，您最多只能添加5只宠物哦！"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text("确认")),
                ],
              );
            });
      } else {
        Navigator.pushNamed(context, "add_pet_page");
        widget.pet_num ++;
      }
    });
  }
}

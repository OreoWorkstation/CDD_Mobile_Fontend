import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_pet_page.dart';

class PetBoard extends StatefulWidget {
  PetBoard({Key key, @required this.index}) : super(key: key);
  var board_colors = [
    Colors.orange,
    Colors.blueAccent,
    Colors.cyan,
    Colors.green,
    Colors.deepPurpleAccent
  ];
  var index;
  @override
  _PetBoardState createState() => _PetBoardState();
}

class _PetBoardState extends State<PetBoard> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width; //360
    var h = MediaQuery.of(context).size.height; //780
    return DecoratedBox(
      decoration: BoxDecoration(
          color: widget.board_colors[widget.index],
          borderRadius: BorderRadius.circular(15.0)),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "  Cat/Dog",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: h / 39,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Material(
                        //borderRadius: BorderRadius.circular(),
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddPetPage(name: "edit name", type: '狗', description: 'edit description content', birth: '2002-1-1',),
                              ),
                            );
                          },
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Material(
                        //borderRadius: BorderRadius.circular(),
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  //提示以达到上限
                                  return new AlertDialog(
                                    title: new Text("提示"),
                                    content: new Text("您确认要删除该宠物么？"),
                                    actions: <Widget>[
                                      new FlatButton(
                                          onPressed: () {
                                            //TODO 2020.3.4.zth [delete function]
                                            print("删除宠物");
                                            Navigator.of(context).pop();
                                          },
                                          child: new Text("确认")),
                                      new FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: new Text("取消"))
                                    ],
                                  );
                                });
                          },
                        ),
                      ))
                ],
              )),
          Expanded(
              flex: 3,
              child: Center(
                child: ClipOval(
                  child: Image.network(
                      // "https://c-ssl.duitang.com/uploads/item/201808/15/20180815112431_keyzi.jpeg"
                      "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2079072528,671755176&fm=26&gp=0.jpg",
                    height: h/5.5,
                    width: h/5.5,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: Text("宠物名称",
                    style: TextStyle(
                      fontSize: h / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "人见人爱，花见花开",
                  style: TextStyle(
                    fontSize: h / 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                  child: Align(
                alignment: Alignment.topCenter,
                child: Text("1 years 2 months",
                    style: TextStyle(
                      fontSize: h / 52,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              )))
        ],
      ),
    );
  }
}

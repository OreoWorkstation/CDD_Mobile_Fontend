import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class BillPage extends StatelessWidget {
  /*final List<String> items;
  Weight({Key key, @required this.items}) : super(key: key);*/
  var items=new List<String>.generate(100, (i) => "Items $i");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          '账单',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.account_balance), onPressed: () {})
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            height: 300,
            color: Colors.lightBlue,
          ),
          new Container(
            decoration: BoxDecoration(
              color: Colors.limeAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: new Column(
              children: <Widget>[
                new Container(
                  height:60,
                  width: 200,
                  margin: EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: () {
                        showDialog<Null>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return new SimpleDialog(
                                title: new Text('请输入新的纪录'),
                                children: <Widget>[
                                  new TextField(
                                    decoration: InputDecoration(
                                      hintText:'请输入消费金额/元',
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  new TextField(
                                    decoration: InputDecoration(
                                      hintText:'请输入消费去向',
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  new RaisedButton(
                                      child:new Text('确定'),
                                      color:Colors.limeAccent,
                                      onPressed: (){}
                                  ),
                                ],
                              );
                            }
                        );
                    },
                    color: Colors.lightBlue,
                    child: new Text('添加'),
                  ),
                ),
                new Container(
                  height:230,
                  child: new ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context,int index) {
                      return new GestureDetector(
                        onTap: (){
                          print("${items[index]}");
                        },
                        child:new ListTile(
                        title: new Text('${items[index]}'),
                        //subtitle: new Text('999'),
                        //trailing: Icon(Icons.keyboard_arrow_right),
                      ),);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

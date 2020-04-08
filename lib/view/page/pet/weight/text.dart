import 'package:flutter/material.dart';
void main () => runApp(MyApp(
    items: new List<String>.generate(1000, (i)=> "Item $i")
));

class MyApp extends StatelessWidget{

  final List<String> items;
  MyApp({Key key, @required this.items}):super(key:key);
  @override
  Widget build(BuildContext context ){
    return MaterialApp(
      title:'ListView widget',
      home:Scaffold(
          body:new ListView.builder(
              itemCount:items.length,
              itemBuilder:(BuildContext context,int index){
                return new ListTile(
                  title:new Text('${items[index]}'),
                );
              }
          )
      ),
    );
  }
}
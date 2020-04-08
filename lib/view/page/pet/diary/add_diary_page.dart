import 'package:flutter/material.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({Key key}) : super(key: key);
  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  GlobalKey<FormState> _diary_formKey = new GlobalKey<FormState>();
  var date = DateTime.now();
  static const sizedBoxSpace = SizedBox(height: 24);
  String _title;
  String _content;
  void _forSubmitted() {
    if(_diary_formKey.currentState.validate()){
      var _form = _diary_formKey.currentState;
      if (_form.validate()) {
        _form.save();
        print(_title);
        print(_content);
      }
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑日记"),
          actions: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 100, //宽度尽可能大
                  maxHeight: 5.0 //最小高度为50像素
                  ),
              child: IconButton(
                padding: EdgeInsets.symmetric(horizontal: 8),
                icon: Icon(Icons.save, color: Colors.black54), //导航栏右侧菜单
                onPressed: () {
                  _forSubmitted();
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _diary_formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "${date.day}",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 30),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "星期${date.weekday}",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          "${date.year}年${date.month}月",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                sizedBoxSpace,
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.assignment),
                    hintText: "${date.year}-${date.month}-${date.day}",
                    labelText: "日记标题",
                  ),
                  onSaved: (val) {
                    _title = val;
                  },
                ),
                sizedBoxSpace,
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "无论忙碌还是闲暇,为你的宠物记录吧",
                    labelText: "日记内容",
                  ),
                  maxLines: 10,
                  onSaved: (val) {
                    _content = val;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

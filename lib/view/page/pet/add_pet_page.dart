import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  AddPetPage({Key key, this.name, this.description, this.type, this.birth})
      : super(key: key);
  String name;
  String description;
  String type;
  String birth;
  @override
  _AddPetPageState createState() => new _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name;
  String _description;
  String _type = '猫';
  String _birth;
  void _forSubmitted() {
//    print(_birth);
//    print(widget.birth);
    _birth == null ? widget.birth : _birth;
    if (_formKey.currentState.validate()) {
      var _form = _formKey.currentState;
      if (_form.validate()) {
        _form.save();
        print(_name);
        print(_description);
        print(_type);
        print(_birth);
      }
      Navigator.pop(context);
    }
  }
  @override
  void initState() {
    print("init");
    _type = widget.type == null ? '猫' : widget.type;
    _birth = widget.birth == null ? '宠物生日' : widget.birth;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height; //780
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('添加宠物'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _forSubmitted,
        child: new Text('添加'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                  decoration: new InputDecoration(
                    icon: Icon(Icons.pets),
                    labelText: '宠物名称',
                  ),
                  onSaved: (val) {
                    _name = val;
                  },
                  validator: (val) {
                    return val.length > 0 ? null : "名称不能为空";
                  },
                  controller: widget.name == null
                      ? null
                      : //若没有传参数 无
                      TextEditingController.fromValue(TextEditingValue(
                          //传了参数    设置默认值
                          text:
                              '${this._name == null ? "${widget.name}" : this._name}',
                        ))),
              SizedBox(
                height: h / 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("宠物类别:",
                    style:
                        TextStyle(fontSize: h / 39, color: Colors.grey[600])),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RadioListTile<String>(
                      value: '猫',
                      title: Text('猫'),
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RadioListTile<String>(
                      value: '狗',
                      title: Text('狗'),
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              new TextFormField(
                  decoration: new InputDecoration(
                      labelText: '宠物描述', icon: Icon(Icons.description)),
                  onSaved: (val) {
                    _description = val;
                  },
                  controller: widget.description == null
                      ? null
                      : //若没有传参数 无
                      TextEditingController.fromValue(TextEditingValue(
                          //传了参数    设置默认值
                          text:
                              '${this._description == null ? "${widget.description}" : this._description}', //判断keyword是否为空
                        ))),
              SizedBox(
                height: h / 30,
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      "宠物生日:",
                      style:
                          TextStyle(fontSize: h / 39, color: Colors.grey[600]),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: new MaterialButton(
                      child: new Text(
                        '选择日期',
                        style: TextStyle(fontSize: h / 39, color: Colors.blue),
                      ),
                      onPressed: () {
                        // 调用函数打开
                        showDatePicker(
                          initialDatePickerMode: DatePickerMode.year,
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime.now()
                              .subtract(new Duration(days: 360 * 100)),
                          lastDate:
                              new DateTime.now().add(new Duration(days: 360)),
                        ).then((DateTime val) {
                          setState(() {
                            _birth = '${val.year}' +
                                '-' +
                                '${val.month}' +
                                '-' +
                                '${val.day}';
                          });
                          print(val);
                        }).catchError((err) {
                          print(err);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _birth == null
                        ? (widget.birth == null ? "宠物生日" : Text("${widget.birth}", style: TextStyle(fontSize: h / 45)))
                        : Text("$_birth", style: TextStyle(fontSize: h / 45)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
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
    if(_formKey.currentState.validate()){
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
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;  //780
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
              ),
              SizedBox(
                height: h/30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("宠物类别:",style: TextStyle(fontSize: h/39, color: Colors.grey[600])),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex : 1,
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
                  Expanded(
                    flex: 2,
                    child: RadioListTile<String>(
                      value: '其它',
                      title: Text('其它'),
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
                obscureText: true,
                onSaved: (val) {
                  _description = val;
                },
              ),
              SizedBox(
                height: h/30,
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text("宠物生日:",style: TextStyle(fontSize: h/39,color: Colors.grey[600]),),
                  ),
                  Expanded(
                    flex: 3,
                    child: new MaterialButton(
                      child: new Text('选择日期',style: TextStyle(fontSize: h/39,color: Colors.blue),),
                      onPressed: () {
                        // 调用函数打开
                        showDatePicker(
                          initialDatePickerMode: DatePickerMode.year,
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime.now().subtract(new Duration(days: 360 * 100)),
                          lastDate: new DateTime.now().add(new Duration(days: 360)),
                        ).then((DateTime val) {
                          setState(() {
                            _birth = '${val.year}' + '-' + '${val.month}' + '-' + '${val.day}';
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
                    child: _birth == null ? Text("宠物生日") : Text("$_birth",style: TextStyle(fontSize: h/45)),
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

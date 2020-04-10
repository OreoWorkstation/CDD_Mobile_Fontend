import 'package:flutter/material.dart';

class CddRegisterPage extends StatefulWidget {
  CddRegisterPage({Key key, @required this.screen_h, @required this.screen_w}) : super(key: key);
  double screen_h;
  double screen_w;
  @override
  _CddRegisterPageState createState() => _CddRegisterPageState();
}

class _CddRegisterPageState extends State<CddRegisterPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _pwdConfirmController = new TextEditingController();
  TextEditingController _NickNameController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = widget.screen_h;
    var w = widget.screen_w;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: (h + h / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blue[600], Colors.indigo],
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: h / 8,
                  ),
                  SizedBox(
                    height: h / 8,
                    width: double.infinity,
                    child: Center(
                      child: Icon(
                        Icons.pets,
                        size: h / 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h / 8,
                    child: Center(
                        child: Text("猫狗日记",
                            style: TextStyle(
                              fontSize: h / 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(6, 3),
                                    blurRadius: 10)
                              ],
                            ))),
                  ),
                  //下方白框
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.elliptical(w / 7, w / 7)),
                      ),
                      child: SizedBox(
                          height: (h - h / 8),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 24.0),
                            child: Form(
                              key: _formKey,
                              autovalidate: true,
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RaisedButton.icon(
                                      color: Colors.blueAccent,
                                      icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                                      label: Text("返回", style: TextStyle(color: Colors.white),),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      shape: new StadiumBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _unameController,
                                    decoration: InputDecoration(
                                        labelText: "用户名",
                                        hintText: "请输入用户名",
                                        icon: Icon(Icons.person)),
                                    validator: (v) {
                                      return v.trim().length > 0 ? null : "用户名不能为空";
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _pwdController,
                                    decoration: InputDecoration(
                                        labelText: "密码",
                                        hintText: "请输入密码",
                                        icon: Icon(Icons.lock)),
                                    obscureText: true,
                                    validator: (v) {
                                      return v.trim().length > 5 ? null : "密码不能少于6位";
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _pwdConfirmController,
                                    decoration: InputDecoration(
                                        labelText: "确认密码",
                                        hintText: "请输入密码",
                                        icon: Icon(Icons.lock_outline)),
                                    obscureText: true,
                                    validator: (v) {
                                      return v == _pwdController.text ? null : "与密码不同";
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _NickNameController,
                                    decoration: InputDecoration(
                                        labelText: "昵称",
                                        icon: Icon(Icons.person_outline)),
                                    obscureText: true,
                                    validator: (v) {
                                      return v == null ? null : "昵称不能为空";
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: RaisedButton(
                                            padding: EdgeInsets.all(15.0),
                                            child: Text("注册"),
                                            color: Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              if ((_formKey.currentState as FormState)
                                                  .validate()) {
                                                print("验证通过 提交数据");
                                                print("用户名：${_unameController.text}");
                                                print("密码：${_pwdController.text}");
                                                print("昵称：${_NickNameController.text}");
                                              } else {
                                                print("验证不通过");
                                              }
                                            },
                                            shape: new StadiumBorder(),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))),
                ],
              ),
            )));
  }
}

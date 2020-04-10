import 'package:cdd_mobile_frontend/view/login_page.dart';
import 'package:cdd_mobile_frontend/view/register_page.dart';
import 'package:flutter/material.dart';

class CddInitPage extends StatefulWidget {
  CddInitPage({Key key}) : super(key: key);
  @override
  _CddInitPageState createState() => _CddInitPageState();
}

class _CddInitPageState extends State<CddInitPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //print("_state：$_state");
    var w = MediaQuery.of(context).size.width; //360
    var h = MediaQuery.of(context).size.height; //780
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              //height: _state <= 2 ? h : (h + h / 4),
              height: h,
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
                      //height: (_state <= 2) ? (h - 3 * h / 8) : (h - h / 8),
                        height: h - 3 * h / 8,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: h / 6,
                              ),
                              SizedBox(
                                width: w - 50,
                                height: h / 15.5,
                                child: FlatButton(
                                  shape: new StadiumBorder(
                                      side: new BorderSide(
                                        style: BorderStyle.solid,
                                        color: Colors.indigo,
                                      )),
                                  child: Text(
                                    '登陆',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: w / 18,
                                        letterSpacing: w / 18),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CddLoginPage(screen_h: h , screen_w: w),
                                      ),
                                    );
                                  },
                                  color: Colors.indigo,
                                ),
                              ),
                              SizedBox(
                                height: h / 12,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                      width: w / 2,
                                      height: h / 15.5,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 25),
                                        child: FlatButton(
                                          shape: new StadiumBorder(
                                              side: new BorderSide(
                                                style: BorderStyle.solid,
                                                color: Colors.indigo,
                                              )),
                                          child: Text(
                                            '注册',
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: w / 18,
                                                letterSpacing: w / 18),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => CddRegisterPage(screen_h: h , screen_w: w),
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                                  SizedBox(
                                      width: w / 2,
                                      height: h / 15.5,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 25),
                                        child: FlatButton(
                                          shape: new StadiumBorder(
                                              side: new BorderSide(
                                                style: BorderStyle.solid,
                                                color: Colors.indigo,
                                              )),
                                          child: Text(
                                            '忘记密码',
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: w / 18,
                                                letterSpacing: 2),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              print("忘记密码按钮");
                                            });
                                          },
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            )));
  }
}

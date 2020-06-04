import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 账号输入框控制器
  final TextEditingController _accountController = TextEditingController();
  // 密码输入框控制器
  final TextEditingController _passwordController = TextEditingController();
  // 重复密码输入框控制器
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  // 取消注册，返回登录界面
  _handleNavSignIn() {
    Navigator.of(context).pop();
  }

  // 注册，返回登录界面
  _handleRegister(BuildContext context) async {
    print(_accountController.text);
    print(_passwordController.text);
    print(_repeatPasswordController.text);
    if (_passwordController.text != _repeatPasswordController.text) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("两次密码不同"),
      ));
      return;
    }
    if (_accountController.text.length < 6 ||
        _passwordController.text.length < 6) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("帐号或密码长度小于6位数"),
      ));
      return;
    }
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    bool res = await provider.register(
        _accountController.text, _passwordController.text);
    if (res == false) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("帐号密码不匹配"),
      ));
      return;
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    return LoadingOverlay(
      color: Colors.transparent,
      isLoading: provider.isBusy,
      child: Scaffold(
        appBar: appBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildRegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: sHeight(0)),
          width: sWidth(130.0),
          height: sWidth(130.0),
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          ),
        ),
        Text(
          "Cat & Dog Diary",
          style: GoogleFonts.satisfy(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Builder(
      builder: (context) => Container(
        width: sWidth(350.0),
        height: sHeight(400.0),
        margin: EdgeInsets.only(top: sHeight(44.0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Radii.k10pxRadius,
          boxShadow: [
            BoxShadow(
              offset: Offset(
                sWidth(13.0),
                sHeight(5.0),
              ),
              color: Colors.black.withOpacity(0.16),
              blurRadius: 33,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: sWidth(13.0), right: sWidth(13.0), top: sHeight(9.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Register",
                style: GoogleFonts.marckScript(
                  fontSize: sSp(42.0),
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryText,
                ),
              ),
              // 输入账号
              inputTextEditWidget(
                controller: _accountController,
                hintText: "账号",
              ),
              // 输入密码
              inputTextEditWidget(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: "密码",
                isPassword: true,
              ),
              // 重复输入密码
              inputTextEditWidget(
                controller: _repeatPasswordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: "重复密码",
                isPassword: true,
              ),
              SizedBox(height: sHeight(40.0)),
              // 取消按钮，注册按钮
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sWidth(12.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    primaryBtn(
                      onPressed: () => _handleNavSignIn(),
                      bgColor: AppColor.secondaryElement,
                      width: 130.0,
                      height: 48.0,
                      title: "取消",
                      fontSize: 19.0,
                    ),
                    primaryBtn(
                      onPressed: () => _handleRegister(context),
                      width: 130.0,
                      height: 48.0,
                      title: "注册",
                      fontSize: 19.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

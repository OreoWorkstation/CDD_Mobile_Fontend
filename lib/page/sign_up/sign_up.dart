import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  _handleRegister() {
    print(_accountController.text);
    print(_passwordController.text);
    print(_repeatPasswordController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _buildLogo() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: cddSetHeight(0)),
          width: cddSetHeight(130.0),
          height: cddSetHeight(130.0),
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
    return Container(
      width: cddSetHeight(300.0),
      height: cddSetHeight(380.0),
      margin: EdgeInsets.only(top: cddSetHeight(44.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Radii.k10pxRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(
              cddSetHeight(13.0),
              cddSetHeight(5.0),
            ),
            color: Colors.black.withOpacity(0.16),
            blurRadius: 33,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: cddSetWidth(13.0),
            right: cddSetWidth(13.0),
            top: cddSetHeight(9.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Register",
              style: GoogleFonts.marckScript(
                fontSize: cddSetFontSize(42.0),
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
            SizedBox(height: cddSetHeight(40.0)),
            // 取消按钮，注册按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                btnFlatButtonWidget(
                  onPressed: () => _handleNavSignIn(),
                  bgColor: AppColor.secondaryElement,
                  width: 130.0,
                  height: 42.0,
                  title: "取消",
                  fontSize: 19.0,
                ),
                btnFlatButtonWidget(
                  onPressed: () => _handleRegister(),
                  width: 130.0,
                  height: 42.0,
                  title: "注册",
                  fontSize: 19.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

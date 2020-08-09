import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSignIn;
  LoginForm({Key key, @required this.onSignIn}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  // 账号控制器
  final TextEditingController _accountController = TextEditingController();
  // 密码控制器
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  bool _isInvalidAsyncUser = false;
  bool _isInvalidAsyncPass = false;

  String _account;
  String _password;
  bool _isLoggedIn = false;

  String _validateAccount(String account) {
    if (account.length < 6) {
      return "账号长度至少8位";
    }

    if (_isInvalidAsyncPass) {
      _isInvalidAsyncPass = false;
      return "账号不存在";
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.length < 6) {
      return "密码长度至少8位";
    }

    if (_isInvalidAsyncPass) {
      _isInvalidAsyncPass = false;
      return "密码错误";
    }
    return null;
  }

  _submit() {
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();

      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Container(
          width: sWidth(350.0),
          height: sHeight(380.0),
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
                left: sWidth(13.0),
                right: sWidth(13.0),
                top: sHeight(9.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Login",
                  style: GoogleFonts.marckScript(
                    fontSize: sSp(42.0),
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryText,
                  ),
                ),
                // 输入账号
                inputTextEditWidget(
                  controller: _accountController,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "账号",
                ),
                // 输入密码
                inputTextEditWidget(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "密码",
                  isPassword: true,
                ),
                SizedBox(height: sHeight(24.0)),
                // 忘记密码
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => print("tap foget password"),
                      child: Text(
                        "忘记密码?",
                        style: TextStyle(
                          color: AppColor.primaryElement,
                          fontSize: sSp(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sHeight(32.0)),
                // 登录按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    primaryBtn(onPressed: () {
                      _submit();
                    }, title: "登录"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

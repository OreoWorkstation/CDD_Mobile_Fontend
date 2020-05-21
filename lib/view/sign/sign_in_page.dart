import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:cdd_mobile_frontend/view/sign/sign_up_page.dart';
import 'package:cdd_mobile_frontend/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // 响应空白处的焦点的Node
  final FocusNode blankNode = FocusNode();
  // 账号控制器
  final TextEditingController _accountController = TextEditingController();
  // 密码控制器
  final TextEditingController _passwordController = TextEditingController();

  // 跳转到注册界面
  _handleNavSignUp() async {
    _accountController.clear();
    _passwordController.clear();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  // 执行登录操作
  _handleSignIn(UserProvider userProvider) async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool isSuccess = await userProvider.signIn(
        _accountController.text, _passwordController.text);
    if (isSuccess) {
      //Navigator.of(context).pushReplacementNamed("/application");
      print("success");
    } else {
      userProvider.showErrorMessage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(),
      body: LoadingOverlay(
        isLoading: false,
        opacity: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildLoginForm(userProvider),
                Spacer(),
                _buildRegisterItem(),
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
        Text("Cat & Dog Diary",
            style:
                GoogleFonts.satisfy(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLoginForm(UserProvider userProvider) {
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
            left: sWidth(13.0), right: sWidth(13.0), top: sHeight(9.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Login",
              style: GoogleFonts.marckScript(
                fontSize: sSp(42.0),
                fontWeight: FontWeight.bold,
                color: Colours.app_main,
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
                InkWell(
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
                primaryBtn(
                  onPressed: () => _handleSignIn(userProvider),
                  title: "登录",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterItem() {
    return Container(
      margin: EdgeInsets.only(bottom: sHeight(35.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sWidth(59)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "没有账号?",
              style: TextStyle(
                fontSize: sSp(17.0),
                color: AppColor.primaryText,
              ),
            ),
            GestureDetector(
              onTap: () => _handleNavSignUp(),
              child: Text(
                "立即注册",
                style: TextStyle(
                  fontSize: sSp(17.0),
                  color: AppColor.primaryElement,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

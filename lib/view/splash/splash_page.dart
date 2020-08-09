import 'dart:ui';

import 'package:cdd_mobile_frontend/common/router/fluro_navigator.dart';
import 'package:cdd_mobile_frontend/common/router/user_router.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 196, 70),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sWidth(20),
                vertical: sHeight(40),
              ),
              child: Text(
                "Welcome",
                style: GoogleFonts.pangolin(
                  fontSize: sSp(35),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.1,
                  wordSpacing: 2.2,
                ),
              ),
            ),
            Container(
              height: sHeight(300),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splash/splash03.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sWidth(20),
                vertical: sHeight(40),
              ),
              child: Text(
                "In this place, you can record your happiness with your pets.",
                style: TextStyle(
                  fontSize: sSp(18),
                  color: Colors.white.withOpacity(.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(bottom: sHeight(60)),
                  child: primaryBtn(
                    onPressed: () {
                      NavigatorUtil.push(
                        context,
                        UserRouter.LOGIN,
                        replace: true,
                      );
                    },
                    title: "Get Started",
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

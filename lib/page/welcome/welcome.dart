import 'package:cdd_mobile_frontend/page/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Image.asset("assets/images/welcome.png"),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ));
                },
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cdd_mobile_frontend/view/page/pet/pet_overview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PetPage extends StatelessWidget {
  const PetPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(123, 104, 238, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Click me"),
          onPressed: () async {
            print("click button in pet page....");
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PetOverviewPage(name: "HHHHH"),
              ),
            );
            print(result);
          },
        ),
      ),
    );
  }
}

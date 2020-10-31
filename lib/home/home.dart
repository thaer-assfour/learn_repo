// Login Success Page

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/login/login_ui.dart';

// ignore: must_be_immutable
class LoginSuccessPage extends StatefulWidget {
  String token;

  @override
  _LoginSuccessPageState createState() => _LoginSuccessPageState();

  LoginSuccessPage(this.token);
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User-ID: " + widget.token),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginUIScreen();
                }));
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}

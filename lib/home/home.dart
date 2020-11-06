// Login Success Page

import 'package:flutter/material.dart';
import 'package:learn_app/welcome/welcome_ui.dart';

// ignore: must_be_immutable
class LoginSuccessPage extends StatefulWidget {
  Map<String, dynamic> userData;

  @override
  _LoginSuccessPageState createState() => _LoginSuccessPageState();

  LoginSuccessPage(this.userData);
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
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(widget.userData["picture"]),
            ),
            Text("Name: " + widget.userData["name"]),
            Text("Email: " + widget.userData["email"]),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return WelcomeUI();
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

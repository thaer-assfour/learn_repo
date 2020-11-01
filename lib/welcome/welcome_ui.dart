import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/login/login_ui.dart';
import 'package:learn_app/register/register_ui.dart';

class WelcomeUI extends StatefulWidget {
  @override
  _WelcomeUIState createState() => _WelcomeUIState();
}

class _WelcomeUIState extends State<WelcomeUI> {
  bool login_Register = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: login_Register ? LoginUIScreen() : RegisterUIScreen(),
          ),
          login_Register
              ? Column(
                  children: [
                    Text("Don't have account? ",
                        style: TextStyle(
                            color: Colors.purple, letterSpacing: 1.1)),
                    InkWell(
                      child: Text(
                        "Register Here",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        setState(() {
                          login_Register = !login_Register;
                        });
                      },
                    )
                  ],
                )
              : Column(
                  children: [
                    Text("Already have account?",
                        style: TextStyle(
                            color: Colors.purple, letterSpacing: 1.1)),
                    InkWell(
                      child: Text(
                        "Login page",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        setState(() {
                          login_Register = !login_Register;
                        });
                      },
                    )
                  ],
                ),
        ],
      ),
    ));
  }
}

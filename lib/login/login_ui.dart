import 'package:flutter/material.dart';
import 'package:learn_app/Auth0/auth_server.dart';
import 'package:learn_app/home/home.dart';

import 'package:learn_app/login/login_service.dart';

class LoginUIScreen extends StatefulWidget {
  @override
  _LoginUIScreenState createState() => _LoginUIScreenState();
}

class _LoginUIScreenState extends State<LoginUIScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Map<String, dynamic> loginResult; // login result from services
  Map<String, dynamic> userProfile; // user profile data after success login
  String _loginMsg; // define the error msg to show on screen

  bool isLoading = false; // to enable circular indicator when loading.
  bool validateName = false; // to enable autoValidate name after starting type.
  bool validatePassword =
      false; // to enable autoValidate password after starting type.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.9),
                borderRadius: BorderRadius.circular(48),
                border: Border.all(
                    color: Colors.purple.withOpacity(0.7), width: 4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login Page",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32, left: 32, top: 24),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    autovalidate: validateName,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Email cannot be empty";
                      else
                        return null; // when return null the validate is true.
                    },
                    onChanged: (val) {
                      setState(() {
                        validateName = true; // start autoValidate.
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 32, left: 32, bottom: 32, top: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    autovalidate: validatePassword,
                    validator: (value) {
                      if (value.isEmpty)
                        return "password cannot be empty";
                      else
                        return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        validatePassword = true; // start autoValidate.
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "password",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                RaisedButton(
                  onPressed: (_emailController.text.isEmpty ||
                          _passwordController.text
                              .isEmpty) // login button valid when 2 fields are not empty.
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true; // end circular indicator.
                            _loginMsg = null;
                          });
                          await login(
                              _emailController.text,
                              _passwordController
                                  .text); // get value from login function.
                          if (loginResult["loginStatus"] == 200) {
                            // value not false => user is valid.
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginSuccessPage(userProfile);
                            }));
                          }
                        },
                  child: Text("Login"),
                ),
                Container(
                  child: isLoading ? CircularProgressIndicator() : null,
                ),
                Container(
                  child: (_loginMsg == null)
                      ? null
                      : Text(
                          _loginMsg,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login(email, password) async {
    final authServer = AuthServer();
    LoginService loginService = LoginService(authServer);
    loginResult = await loginService.login(email, password);

    if (loginResult["loginStatus"] == 200)
      userProfile = await loginService.getProfile(loginResult["access_token"]);
    else
      _loginMsg = loginResult["error_description"].toString();

    setState(() {
      isLoading = false;
    });
  }
}

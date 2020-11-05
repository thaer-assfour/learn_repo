import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/Auth0/auth_server.dart';
import 'package:learn_app/fake_server/fake_server.dart';
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

  bool isLoading = false; // to enable circular indicator when loading.
  String loginState; // return value from login.
  bool validateName = false; // to enable autoValidate name after starting type.
  bool validatePassword =
      false; // to enable autoValidate password after starting type.

  // TODO: This Should reflect the 3 states of the screen, Connection Error, Login Success, Login Failed
  // To test this, AFTER implenting Auth0 Logic, Login Correctly, Login With false info, and Login with no internet
  // The Login Screen should tell you what is going
  // Think of a way to combine the states into a single variable ;)
  // TODO: Add a Link to Register Page
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
                            loginState = null; // initial val for login state.
                          });
                          await login(
                              _emailController.text,
                              _passwordController
                                  .text); // get value from login function.
                          if (loginState != "false") {
                            // value not false => user is valid.
                            /*Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginSuccessPage(loginState);
                            }));*/
                          }
                        },
                  child: Text("Login"),
                ),
                Container(
                  child: isLoading ? CircularProgressIndicator() : null,
                ),
                Container(
                  child: (loginState != "false" ||
                          loginState ==
                              null) // when login state is false return error msg.
                      ? null
                      : Text(
                          "Email or password is incorrect",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<String> login(email, password) async {
    final authServer = AuthServer();
    LoginService loginService = LoginService(authServer);
    loginState = await loginService.login(email, password);
    print(loginState);
    setState(() {
      isLoading = false;
    });
    return "";
  }
}

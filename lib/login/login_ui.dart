// Design Goes Here
import 'package:flutter/material.dart';
import 'package:learn_app/home/home.dart';
import 'package:learn_app/login/login_service.dart';

class LoginUIScreen extends StatefulWidget {
  @override
  _LoginUIScreenState createState() => _LoginUIScreenState();
}

class _LoginUIScreenState extends State<LoginUIScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false; // to enable circular indicator when loading.
  var loginState; // return value from login.
  bool validateName = false; // to enable autoValidate name after starting type.
  bool validatePassword =
      false; // to enable autoValidate password after starting type.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: TextFormField(
                  controller: _userNameController,
                  autovalidate: validateName,
                  validator: (value) {
                    if (value.isEmpty)
                      return "username cannot be empty";
                    else
                      return null; // when return null the validate is true.
                  },
                  onChanged: (val) {
                    setState(() {
                      validateName = true; // start autoValidate.
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "User name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32, bottom: 32),
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
                  ),
                  obscureText: true,
                ),
              ),
              RaisedButton(
                onPressed: (_userNameController.text.isEmpty ||
                        _passwordController.text.isEmpty) // login button valid when 2 fields are not empty.
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true; // end circular indicator.
                          loginState = null; // initial val for login state.
                        });
                        await login(
                            _userNameController.text, _passwordController.text); // get value from login function.
                        if (loginState != false) { // value not false => user is valid.
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginSuccessPage(loginState);
                          }));
                        }
                      },
                child: Text("Login"),
              ),
              Container(
                child: isLoading ? CircularProgressIndicator() : null,
              ),
              Container(
                child: (loginState != false || loginState == null) // when login state is false return error msg.
                    ? null
                    : Text(
                        "username or password is incorrect",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic login(email, password) async {
    // Get the Username and password from the EditTextControllers here, and user LoginService to post these results
    LoginService loginService = LoginService();
    loginState = await loginService.login(email, password);
    setState(() {
      isLoading = false;
    });
    return loginState;
  }
}

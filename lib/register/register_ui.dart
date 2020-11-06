
import 'package:flutter/material.dart';
import 'package:learn_app/Auth0/auth_server.dart';
import 'package:learn_app/register/register_service.dart';

class RegisterUIScreen extends StatefulWidget {
  @override
  _RegisterUIScreenState createState() => _RegisterUIScreenState();
}

class _RegisterUIScreenState extends State<RegisterUIScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Map<String, dynamic> registerResult;
  String _registerMsg; // define the error msg to show on screen

  bool isLoading = false; // to enable circular indicator when loading.
  String registerState; // return value from login.
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
                border: Border.all(color: Colors.purple.withOpacity(0.7),width: 4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register New User Account",
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
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value))
                        return 'Enter Valid Email';
                      else
                        return null; // when return null the validate is true.
                    },
                    onChanged: (val) {
                      setState(() {
                        validateName = true; // start autoValidate.
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Email ",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 32, left: 32, bottom: 32, top: 16),
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
                            _registerMsg =
                                null; // initial val for login state.
                          });
                          await register(
                              _emailController.text,
                              _passwordController
                                  .text); // get value from login function.
                        },
                  child: Text("Register"),
                ),
                Container(
                  child: isLoading ? CircularProgressIndicator() : null,
                ),
                Container(
                    child: (_registerMsg !=
                            null) // when login state is false return error msg.
                        ? Text(
                            _registerMsg,
                            style: TextStyle(
                                color: (registerResult["registerStatus"] == 200) ? Colors.blue : Colors.redAccent,
                                fontWeight: FontWeight.w600),
                          )
                        : null),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future register(email, password) async {
    final authServer = AuthServer();
    RegisterService registerService = RegisterService(authServer);
    registerResult = await registerService.register(email, password);
    print(registerResult["registerStatus"]);
    if (registerResult["registerStatus"] == 200)
      _registerMsg = "Register succeeded";
    else
      _registerMsg = registerResult["description"].toString();


    setState(() {
      isLoading = false;
    });

  }
}

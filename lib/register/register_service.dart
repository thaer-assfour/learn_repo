import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:learn_app/Auth0/auth_server.dart';

class RegisterService {

  Map<String, dynamic> _result;
  final AuthServer _authServer = AuthServer();

  RegisterService(_authServer);


  Future<Map<String, dynamic>> register(String email, String password) async {
    Map<String, dynamic> _data = {'email': email, 'password': password};

    Response response = await _authServer.signUp(_data).timeout(
        Duration(seconds: 5));

    if (response != null) {
      _result = jsonDecode(response.body);
      _result["registerStatus"] = response.statusCode;
    } else {
      _result = {
        "loginStatus": 999,
        "description": "No internet service - connection Time out",
      };


    }

    return _result;
  }
}
// Requests and API Logic Happens Here.

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:learn_app/Auth0/auth_server.dart';

class LoginService {
  final AuthServer _authServer = AuthServer();
  Map<String, dynamic> _result;

  LoginService(_authServer);

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, String> data = {'email': email, 'password': password};

    Response response =
        await _authServer.login(data).timeout(Duration(seconds: 5));
    if (response != null) {
      _result = jsonDecode(response.body);
      _result["loginStatus"] = response.statusCode;
    } else {
      _result = {
        "loginStatus": 999,
        "error_description": "No internet service - connection Time out",
      };
    }

    return _result;
  }

  Future<Map<String, dynamic>> getProfile(String accessToken) async {
    Response response = await _authServer.getProfile(accessToken);
    _result = jsonDecode(response.body);
    return _result;
  }

}

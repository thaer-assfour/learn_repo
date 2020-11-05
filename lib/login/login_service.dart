// Requests and API Logic Happens Here.

import 'dart:convert';
import 'package:http/http.dart';
import 'package:learn_app/Auth0/auth_server.dart';

class LoginService {
  final AuthServer _authServer = AuthServer();

  LoginService(_authServer);

  Future<String> login(String email, String password) async {
    Map<String, String> data = {'email': email, 'password': password};

    Response response = await _authServer.login(data);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body["access_token"];
    } else
      return "Error";
  }
}

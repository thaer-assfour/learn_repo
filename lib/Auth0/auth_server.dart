import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'auth0_setting.dart';

class AuthServer {


  Future<http.Response> signUp(Map<String, dynamic> data) async {
    String _email = data['email'];
    String _password = data['password'];

    String url = "$authDomain" + "/dbConnections/signUp";
    Map<String, String> body = {
      "client_id": "$authClientId",
      "email": "$_email",
      "password": "$_password",
      "connection": "$authConnectionUPA"
    };


    try {
      var response = await http.post(url, body: body);

      return response;
    } on SocketException catch (e) {
      return null;
    }



  }

  Future<http.Response> login(Map<String, String> data) async {
    String _email = data['email'];
    String _password = data['password'];

    String url = "$authDomain" + "/oauth/token";
    Map<String, String> body = {
      "grant_type": "$grantType",
      "client_id": "$authClientId",
      "audience": "$audience",
      "username": "$_email",
      "password": "$_password",
      "client_secret": "$clientSecret",
      "scope": "$scope"
    };

    try {
      var response = await http.post(url, body: body);
      return response;
    } on SocketException catch (e) {
      return null;
    }
  }

  Future<http.Response> getProfile(String accessToken) async {
    String url = "$authDomain" + "/userinfo";
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
  }
}

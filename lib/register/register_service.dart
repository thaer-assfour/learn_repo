import 'dart:async';

import 'package:http/http.dart';
import 'package:learn_app/Auth0/auth_server.dart';

class RegisterService {

  final AuthServer _authServer = AuthServer();


  RegisterService(_authServer);


  Future<String> register(String email, String password) async {

    Map<String, dynamic> _data = {'email': email, 'password': password};

    Response response = await _authServer.signUp(_data);

      if(response.statusCode == 200)
        return "Success";
        else
          return "Error";

  }


}

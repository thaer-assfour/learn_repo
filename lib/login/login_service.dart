// Requests and API Logic Happens Here.

import 'package:learn_app/fake_server/fake_server.dart';

class LoginService {
  // Post Login Details Here, and Publish Results to LoginUIScreen
  // NOTE: HTTP_CLIENT ONLY HERE

  FakeServer _fakeServer = FakeServer();

  Future<dynamic> login(String email, String password) async {
    // Post the result to the server. if logged in return true, else return false
    // Use FakeServer Class for now

    Map<String, dynamic> data = {'email': email, 'password': password};
    dynamic response = await _fakeServer.post(data);

    if (response == false) // if user data is invalid return false login
      return false;
    else
      return response['token']; // if user data is valid return token data for user
  }
}

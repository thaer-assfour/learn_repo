// Requests and API Logic Happens Here.

import 'package:learn_app/fake_server/fake_server.dart';

class LoginService {
  // TODO: This should be final
  final FakeServer _fakeServer = FakeServer();

  // TODO: Inject Server into the constructor
  LoginService(_fakeServer);

  // TODO: NEVER USE DYNAMIC
  Future<String> login(String email, String password) async {

    Map<String, String> data = {'email': email, 'password': password};

    // TODO Replace This with Real Login, Use Auth0 https://auth0.com/
    dynamic response = await _fakeServer.post(data);

    // TODO: Response was Changed, Please update your code te reflect the exact result
    if (response == false) // if user data is invalid return false login
      return "false";
    else
      return response['token']; // if user data is valid return token data for user
  }


}

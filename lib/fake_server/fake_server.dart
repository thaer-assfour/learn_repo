class FakeServer {
  Future<dynamic> post(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));

    if (data['email'] == 'admin' && data['password'] == 'admin') {
      return {'token': 'Admin-Token'}; // when user is correct return the token for given user.
    } else {
      return false; // when user is invalid return false.
    }
  }
}

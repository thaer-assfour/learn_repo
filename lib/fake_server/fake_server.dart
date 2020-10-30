class FakeServer {
  Future<dynamic> post(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 3));

    if (data['email'] == 'admin' && data['password'] == 'admin') {
      return {
        'token': 'sometoken'
      };
    } else {
      return null;
    }
  }

}
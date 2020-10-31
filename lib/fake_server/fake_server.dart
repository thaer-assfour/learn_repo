import 'dart:math';

class FakeServer {
  Future<dynamic> post(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));

    if (data['email'] == 'admin' && data['password'] == 'admin') {
      int rand = Random().nextInt(100);
      if (rand % 2 == 0) {
        return {'token': 'Admin-Token'}; 
      } else {
        return {'err': 'Connection Timed out'};
      }
    } else {
      return {'err': 'No User with this credentials was found'}; 
    }
  }
}

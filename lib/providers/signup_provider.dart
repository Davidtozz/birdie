import 'package:flutter/cupertino.dart';
import 'package:birdie/models/user.dart';
import 'package:http/http.dart' as http;

class SignUpProvider with ChangeNotifier {
  static late User user;
  final url = 'https://birdie-auth-testing.herokuapp.com/api/users/new';

  void createUser({required username, required email, required password}) {
    user = User(username: username, email: email, psw: password);
    http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: user.toJson());
    notifyListeners();
  }

  static get justRegisteredUser => user;
}

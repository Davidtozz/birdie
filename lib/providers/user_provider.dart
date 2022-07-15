import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:birdie/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends User with ChangeNotifier {
  UserProvider() : super(name: '', psw: '', mail: '');

  // final user = User(username: '', email: '', psw: '');

  final newUserRoute = 'https://birdie-auth-testing.herokuapp.com/api/users/new';
  final loginRuote = 'https://birdie-auth-testing.herokuapp.com/api/users/login';
  final usersRoute = 'https://birdie-api.herokuapp.com/api/users/';

  Future<void> createUser(
      {required String username,
      required String email,
      required String password}) async {
    User(name: username, mail: email, psw: password);
    return await http
        .post(Uri.parse(newUserRoute),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(
                {'username': username, 'email': email, 'psw': password}))
        .then((value) => notifyListeners());
  }

  // Future<void> logUserIn({required String username, required String password}) {
  //   var loggingUser = User(name: username, psw: password);

  //   return http.post(Uri.parse(loginRuote),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(loggingUser.toJson()));
  // }

  Future<void> get userData async => await http.get(Uri.parse(usersRoute + loggedUser!));

  String? get loggedUser => User.getUsername();

  // get justRegisteredUser => user;
}

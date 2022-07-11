import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:birdie/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier{
  
  final url = 'https://birdie-auth-testing.herokuapp.com/api/users/new';

  Future<void> createUser({username,  email, password}) async {
    final user = User(username: username, email: email, psw: password);
     return await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode(user.toJson())
      
    ).then((value) => notifyListeners());

    
  }

  // get justRegisteredUser => user;
}

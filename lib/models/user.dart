// import 'package:http/http.dart' as http; // ? List all users from DB (might be an idea)

class User {
  static String? username;
  static String? email; // ? Email isn't required for login
  static String? password;

  User({required String name, String? mail, required String psw}) {
    username = name;
    email = mail;
    password = psw;
  }

  // set username(String username) => _username = username;

  static String? getUsername() => username;
  String? getEmail() => email;
  String? getPassword() => password;
  // set email(String email) => _email = email;

  // set psw(String psw) => _psw = psw;

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['psw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['psw'] = password;
    return data;
  }
}

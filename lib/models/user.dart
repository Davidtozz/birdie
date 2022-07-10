class User {
  late final String _username;
  late final String _email;
  late final String _psw;

  User({required String username, required String email, required String psw}) {
    _username = username;
    _email = email;
    _psw = psw;
  }

  // set username(String username) => _username = username;

  String get username => _username;
  String get email => _email;
  String get password => _psw;
  // set email(String email) => _email = email;

  // set psw(String psw) => _psw = psw;

  User.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _email = json['email'];
    _psw = json['psw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = _username;
    data['email'] = _email;
    data['psw'] = _psw;
    return data;
  }
}

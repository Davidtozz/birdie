import 'package:flutter/cupertino.dart';
import 'package:is_first_run/is_first_run.dart';

class FirstRunProvider with ChangeNotifier {
  bool? _isFirstRun;

  void checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();

    if (ifr == true) {
      _isFirstRun = true;
      notifyListeners();
    }
  }

  get stRun => _isFirstRun;
}

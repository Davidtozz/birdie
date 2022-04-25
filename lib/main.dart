import 'package:birdie/forms/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:birdie/introduction/intro_slider.dart';
import 'package:flutter/services.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:birdie/forms/signup_form.dart' as form;

import 'home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isFirstRun;
  // bool? _isFirstCall;

  

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();

    if (ifr) {
      setState(() {
        _isFirstRun = true;
      });
    } else {
      setState(() {
        _isFirstRun = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirstRun();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Birdie',
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      debugShowCheckedModeBanner: false,

      home: SignUpForm()
      //  _isFirstRun == true ? IntroSliderPage() : const Home(),
      
       //TODO: create 
     
    );
  }
}

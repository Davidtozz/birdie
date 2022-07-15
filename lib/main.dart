// import 'package:birdie/forms/login_form.dart';
// import 'package:birdie/home/home.dart';
import 'dart:io';

import 'package:birdie/forms/signup_form.dart';
import 'package:birdie/providers/contact_provider.dart';
import 'package:flutter/material.dart';

import 'forms/login_form.dart';
import 'introduction/intro_slider.dart';
import 'package:provider/provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:birdie/providers/firstrun_provider.dart';

import 'providers/user_provider.dart';


//import provider

Future setDefaultDesktopWindowSize() async {
  Size size = await DesktopWindow.getWindowSize();
  debugPrint('$size');
  await DesktopWindow.setWindowSize(const Size(500, 800));

  await DesktopWindow.setMinWindowSize(const Size(500, 800));
  await DesktopWindow.setMaxWindowSize(const Size(500, 800));
  // await DesktopWindow.setMaxWindowSize(const Size(400, 800));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    setDefaultDesktopWindowSize();
  }
  

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => FirstRunProvider(),
      ),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ContactProvider())
      

    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    final isFirstRun = Provider.of<FirstRunProvider>(context);
    return MaterialApp(
        title: 'Birdie',
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        debugShowCheckedModeBanner: false,
        home: SignUpForm()
        
        // IntroSliderPage()

        // isFirstRun.stRun == true ? IntroSliderPage() :  const LogInForm()

        // Test()

        );
  }
}

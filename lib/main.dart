import 'package:birdie/forms/login_form.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'introduction/intro_slider.dart';
import 'package:provider/provider.dart';
//import provider

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // GetIt.I.registerSingleton<IsFirstRun>(IsFirstRun());
  runApp(
    MultiProvider(providers: [
      Provider(create: (_) => IsFirstRun()),
    ], child: const MyApp()),
    );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isFirstRun;
  // bool? _isFirstCall;

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();

    if (ifr == true) setState(() { _isFirstRun = true; });
      
    
  }

  @override
  void initState() {
    super.initState();
    _checkFirstRun();
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        
        title: 'Birdie',
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        debugShowCheckedModeBanner: false,
        home: 
        // Home(username: 'davidtozz',)
        
        _isFirstRun == true ? IntroSliderPage() :  const LogInForm()
        
        // Test()

       

        );
  }
}

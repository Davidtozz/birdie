import 'package:birdie/forms/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:birdie/introduction/intro_slider.dart';

import 'forms/signup.dart';
import 'home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /* ErrorWidget.builder = (details) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.red,
          child: SvgPicture.asset('assets/images/503.svg', height: 100,),
        

        // return Center(
        //   child:  Text("Error: ${details.exception.toString()}"), 
        
        

        // return Scaffold(
        //   floatingActionButton: null,
        //   body: SizedBox(
        //     height: 200,
        //     child: SvgPicture.asset(
        //       'assets/images/503.svg',
        //       height: 100,
        //     ),
        //   ),
          // Wrap(
          //   direction: Axis.vertical,
          //   children:
          //   const SizedBox(height: 20),
          //   Text(
          //     'Oops! Something went wrong.',
          //     style:
          //         GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500),
          //   )] ,
        ),
      ],
    );
  };
  */
  runApp(const MyApp());
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
        home: Home()
        // _isFirstRun == true ? IntroSliderPage() : const Home()
        // Home(),
        // Test()

        //TODO: create

        );
  }
}

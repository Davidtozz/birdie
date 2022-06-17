import 'package:birdie/shared/globalcolors.dart';
import 'package:birdie/home/home.dart';
import 'package:birdie/shared/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final Key _formKey = GlobalKey<_LogInFormState>();

  // final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(children: [
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 47),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.roboto(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset('assets/images/login.svg',
                      height: 180, width: 180),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  UsernameTextField(controller: _usernameController),
                  PasswordTextField(controller: _passwordController),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      //TODO: fix validation

                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              alignment: Alignment.topLeft,
                              type: PageTransitionType.rightToLeftWithFade,
                              child: Home(username: _usernameController.text)));
                    },
                    //TODO: insert input validation dialog

                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(GlobalColors.purple),
                    ),
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ),
                ],
              ))
        ])),
      ),
    );
  }
}

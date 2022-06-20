import 'dart:convert';

import 'package:birdie/forms/login_form.dart';
import 'package:birdie/home/contacts.dart';
import 'package:birdie/shared/globalcolors.dart';
import 'package:birdie/home/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:birdie/shared/avatar.dart';


import '../shared/forms.dart';
// import 'package:image_picker/image_picker.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // static final ImagePicker _picker = ImagePicker();
  // late Future<XFile?> image;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        reverse: true,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    // const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Create your Birdie profile!',
                            style: GoogleFonts.roboto(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: const Avatar(
                            icon: FontAwesomeIcons.arrowUpFromBracket,
                            size: 22),
                      ),
                      onTap: () {},
                    ),

                    UsernameTextField(
                      controller: _usernameController,
                    ),
                    EmailTextField(
                      controller: _emailController,
                    ),
                    PasswordTextField(
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var url =
                              'https://birdie-auth-testing.herokuapp.com/api/users/new';

                          //TODO: send avatar to S3
                          var user = json.encode({
                            'username': _usernameController.text,
                            'email': _emailController.text,
                            'psw': _passwordController.text,
                          });
                          http.post(Uri.parse(url),
                              headers: {'Content-Type': 'application/json'},
                              body: user);

                          debugPrint(user);
                        }
                        

                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: Home(username: _usernameController.text,),
                                type:
                                    PageTransitionType.rightToLeftWithFade));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: GlobalColors.purple,

                        // backgroundColor:
                        //     MaterialStateProperty.all(GlobalColors.purple),
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: GoogleFonts.roboto(
                                color: GlobalColors.black)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    childCurrent: const SignUpForm(),
                                      alignment: Alignment.topLeft,
                                      type: PageTransitionType
                                          .rightToLeftJoined,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: const LogInForm()));
                            },
                            child: Text(' Sign in',
                                style: GoogleFonts.roboto(
                                    color: GlobalColors.purple))),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    ));
  }
}






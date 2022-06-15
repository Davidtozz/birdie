import 'dart:convert';

import 'package:birdie/forms/login_form.dart';
import 'package:birdie/globalcolors.dart';
import 'package:birdie/home/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:birdie/shared/avatar.dart';
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
    return SafeArea(
      left: false,
      right: false,
      child: Scaffold(
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

                       UsernameTextField(controller: _usernameController,),
                       EmailTextField(controller: _emailController,),
                       PasswordTextField(controller: _passwordController,),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var url =
                                'https://birdie-auth-testing.herokuapp.com/api/users/newuser';

                            http.post(Uri.parse(url), 
                            
                            body: json.encode({
                              'username': _usernameController.text,
                              'email': _emailController.text,
                              'psw': _passwordController.text,
                            }),
                            
                            
                            );
                          }

                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const Home(),
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
                                        alignment: Alignment.topLeft,
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: const LogInForm()));
                              },
                              child: Text(
                                ' Sign in',
                                style: GoogleFonts.roboto(
                                    color: GlobalColors.purple),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      )),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    Key? key,
    required this.controller,
  })  : super(key: key);

  final TextEditingController controller;




  @override
  Widget build(BuildContext context) {
    return Container(
      // ! USERNAME
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        onFieldSubmitted: ((value) {
          // request = http.post(Uri.parse('http://localhost:3000/api/register'))
        }),

        cursorColor: GlobalColors.purple,
        // key: _formKey,

        textInputAction: TextInputAction.next,
        controller: controller,
        validator: (value) {
          value = controller.text;

          if (value.length > 16) {
            return 'Username must be less than 16 characters';
          }

          if (value.contains(RegExp(r'[^a-z]'))) {
            return 'Username must be lowercase';
          }
          return null;
        },

        keyboardType: TextInputType.text,

        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.person,
            color: GlobalColors.purple,
          ),
          isDense: true,
          labelText: 'Username',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColors.purple, width: 2.0)

              //    TODO: change input field border color

              ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key, required this.controller,
  })  : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // !   PASSWORD
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: true,
        obscuringCharacter: '*',
        decoration: const InputDecoration(
          focusColor: GlobalColors.purple,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: GlobalColors.purple,
          ),
          isDense: true,
          // filled: true,
          labelText: 'Password',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColors.purple)

              //    TODO: change input field border color

              ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key, required this.controller,
  })  : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // !     EMAIL
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.alternate_email_rounded,
            color: GlobalColors.purple,
          ),
          isDense: true,
          labelText: 'Email',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: GlobalColors.purple)

              //    TODO: change input field border color

              ),
        ),
      ),
    );
  }
}

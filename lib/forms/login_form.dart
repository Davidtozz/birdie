import 'dart:convert';

import 'package:birdie/forms/signup_form.dart';
import 'package:birdie/shared/globalcolors.dart';
import 'package:birdie/home/home.dart';
import 'package:birdie/shared/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }


  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          var url =
                              'https://birdie-auth-testing.herokuapp.com/api/users/login';

                          await http
                              .post(
                            Uri.parse(url),
                            headers: {'Content-Type': 'application/json'},
                            body: json.encode({
                              'username': _usernameController.text,
                              'psw': _passwordController.text,
                            }),
                          ).then((response) {
                            if (response.statusCode == 404) {
                              debugPrint(response.statusCode.toString());
                              setState(() {
                                _usernameController.text = "";
                                _passwordController.text = "";
                                _isLoading = false;
                              });

                              return ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Invalid username or password!'),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              debugPrint(response.statusCode.toString());

                              return Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child:
                                      Home(username: _usernameController.text),
                                ),
                              );
                            }
                          });
                        }

                        // Navigator.pushReplacement(
                        //     context,
                        //     PageTransition(
                        //         alignment: Alignment.topLeft,
                        //         type: PageTransitionType.rightToLeftWithFade,
                        //         child:
                        //             Home(username: _usernameController.text)));
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Don't have an account?",
                                  style: GoogleFonts.roboto(
                                      color: GlobalColors.black)),
                        GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      childCurrent: const LogInForm(),
                                        alignment: Alignment.topLeft,
                                        type: PageTransitionType
                                            .leftToRightJoined,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: const SignUpForm()));
                              },
                              child: Text('  Sign up',
                                  style: GoogleFonts.roboto(
                                      color: GlobalColors.purple))),
                      ],
                    ),
                          
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Visibility(
                visible: _isLoading,
                child: const CircularProgressIndicator(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

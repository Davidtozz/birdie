import 'package:birdie/forms/login_form.dart';
import 'package:birdie/globalcolors.dart';
import 'package:birdie/home/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

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
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Text(
                          'Create your Birdie profile!',
                          style: GoogleFonts.roboto(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: SvgPicture.asset('assets/images/profilepic.svg',
                            height: 180),
                        //  ProfilePicture(
                        //     firstChild: Text('ciao'),
                        //     secondChild: Text('buongiorno'))
                      ),
                      onTap: () async => {},
                      //TODO: make avatar editable with gallery photo (pub.dev: editable_image)
                      // TODO: https://www.youtube.com/watch?v=MSv38jO4EJk
                    ),
                    UsernameTextField(usernameController: _usernameController),
                    EmailTextField(emailController: _emailController),
                    PasswordTextField(
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          return;
                        }

                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const Home(),
                                type: PageTransitionType.rightToLeftWithFade));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(GlobalColors.purple),
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
                            style:
                                GoogleFonts.roboto(color: GlobalColors.black)),
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
                              'Sign in',
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
    ));
  }
}

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    Key? key,
    required TextEditingController usernameController,
  })  : _usernameController = usernameController,
        super(key: key);

  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ! USERNAME
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: FormBuilderTextField(
        onSubmitted: ((value) {
          // request = http.post(Uri.parse('http://localhost:3000/api/register'))
        }),

        cursorColor: GlobalColors.purple,
        // key: _formKey,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        controller: _usernameController,
        validator: (value) {
          value = _usernameController.text;

          if (value.isNotEmpty && value.length > 3) {
            return null;
          } else if (value.length > 24) {
            return 'Username must be less than 24 characters';
          }
        },

        keyboardType: TextInputType.text,
        name: 'username',
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
    Key? key,
    required TextEditingController passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // !   PASSWORD
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: FormBuilderTextField(
        textInputAction: TextInputAction.next,
        obscureText: true,
        obscuringCharacter: '*',
        name: 'password',
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
    Key? key,
    required TextEditingController emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // !     EMAIL
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: FormBuilderTextField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        name: 'email',
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

/* // ! Attempt to change avatar image
class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key, required this.swap}) : super(key: key);

  final bool swap;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  bool swap = false;

  @override
  void initState() {
    swap = widget.swap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: swap ? first : second,
    );
  }
}
*/
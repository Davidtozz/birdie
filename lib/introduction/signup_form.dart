import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final _formKey = GlobalKey<FormBuilderState>();

  static final ImagePicker _picker = ImagePicker();
  late Future<XFile?> image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
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
                          child: SvgPicture.asset('assets/images/profilepic.svg',height: 180),
                          //  ProfilePicture(
                          //     firstChild: Text('ciao'),
                          //     secondChild: Text('buongiorno'))

                          
                          ),
                      onTap: () async => {},
                      //TODO: make avatar editable with gallery photo (pub.dev: editable_image)
                      // TODO: https://www.youtube.com/watch?v=MSv38jO4EJk

                    ),
                    Container(
                      // USERNAME
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        
                        keyboardType: TextInputType.text,
                        name: 'username',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF6C63FF),
                          ),
                          isDense: true,
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6C63FF))

                              //    TODO: change input field border color

                              ),
                        ),
                      ),
                    ),
                    Container( //      EMAIL
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        name: 'email',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email_rounded,
                            color: Color(0xFF6C63FF),
                          ),
                          isDense: true,
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6C63FF))

                              //    TODO: change input field border color 
                              
                              ),
                        ),
                      ),
                    ),
                    Container(
                     //    PASSWORD

                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        obscuringCharacter: '*',
                        name: 'password',
                        decoration: const InputDecoration(

                          prefixIcon: Icon(
                            Icons.password,
                            color: Color(0xFF6C63FF),
                          ),
                          isDense: true,
                          // filled: true,
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6C63FF))

                              //    TODO: change input field border color

                              ),
                        ),
                      ),
                    ),
                    Container(
                        // PHONE NUMBER 

                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        name: 'number',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android_rounded,
                            color: Color(0xFF6C63FF),
                          ),
                          isDense: true,
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6C63FF))

                              //    TODO: change input field border color

                              ),
                        ),
                      ),
                    ),
                     
                     SizedBox(height: 3),

                     ElevatedButton(
                       onPressed: () {}, 
                       style: ButtonStyle(
                        
                      //  fixedSize: MaterialStateProperty.all(const Size(100,40)),
                         
                        //  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                         backgroundColor: MaterialStateProperty.all(const Color(0xFF6C63FF)),
                       ),
                       child: Text('Sign Up', style: GoogleFonts.roboto(color: Colors.white),),

                     ),

                      SizedBox(height: 10),

                         Row(

                           mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('Already have an account?', style: GoogleFonts.roboto(color:const Color.fromARGB(255, 47, 46, 65))),
                           
                           GestureDetector(
                             onTap: () {
                               print("tapped");
                              //  Navigator.push(
                              //    context, //TODO: make it go back to the login page
                              //    MaterialPageRoute(builder: (context) => LoginPage()),
                              //  );
                             },
                             child: Text(' Sign in', 
                             style: GoogleFonts.roboto(color: const Color(0xFF6C63FF)), 
                            )
                           ),
                                                 
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

// class ProfilePicture extends StatefulWidget {
//   const ProfilePicture({Key? key, required this.swap}) : super(key: key);

//   final bool swap;

//   @override
//   State<ProfilePicture> createState() => _ProfilePictureState();
// }

// class _ProfilePictureState extends State<ProfilePicture> {
//   bool swap = false;

//   @override
//   void initState() {
//     swap = widget.swap;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: swap ? first : second,
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}




class _FormState extends State<Form> {
  final _formKey = GlobalKey<FormBuilderState>();


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
        child: Center(child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
            
          children: [
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction, 
                  
                child: Column(
                    
                  children: <Widget>[
                    SizedBox(height:60),
                     Align(
                      alignment: Alignment.topLeft,
                      child:  Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Text('Create your Birdie profile!', 
                          style: GoogleFonts.roboto(fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                     
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                    child: SvgPicture.asset('assets/images/profiledetails.svg', height: 180),
                  ),


                    Container(
                      
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(   
                        keyboardType: TextInputType.emailAddress,
                        name: 'email',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_rounded, color: Color(0xFF6C63FF),),
                          isDense: true,
                          labelText: 'Email',
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
                        obscureText: true,
                        obscuringCharacter: '*',
                        name: 'password',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password, color: Color(0xFF6C63FF),),
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
                     
                     
                     Container( //    PASSWORD 
                      
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(   
                        keyboardType: TextInputType.number,
                        name: 'number',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_android_rounded, color: Color(0xFF6C63FF),),
                          isDense: true,
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6C63FF))

                        //    TODO: change input field border color
                        
                       
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ]),
         ),
     ) );
  }
}

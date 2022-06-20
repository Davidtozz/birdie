import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'globalcolors.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // !     EMAIL
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          value = controller.text;
          if (value.isEmpty) {
            return 'Email required';
          }

          if (!EmailValidator.validate(value)) {
            return 'Invalid email';
          }
          return null;
        },
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


// **************************************************************************

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // !   PASSWORD
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        obscureText: true,
        obscuringCharacter: '*',
        validator: (value) {
          value = controller.text;
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          //special characters regex

          return null;
        },
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

// **************************************************************************
class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

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

          if (value.length > 10) {
            return 'Username must be less than 10 characters';
          } else if (value.contains(RegExp(r'[^a-z]'))) {
            return 'Username must be lowercase';
          }else if(value.contains(' ')){
            return 'Username cannot contain spaces';
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

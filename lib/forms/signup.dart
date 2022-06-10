import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:email_validator/email_validator.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            //add key to form
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      value = _nameController.text;
                      if (value.isEmpty) {
                        return 'Username required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          // color: Colors.black,
                          fontSize: 20,
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.black),

                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      value = _emailController.text;
                      if (value.isEmpty) {
                        return 'Email required';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          // color: Colors.black,
                          fontSize: 20,
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.black),

                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          // color: Colors.black,
                          fontSize: 20,
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.black),

                          ),
                    ),
                  ),
                ),

                //submit button
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        const CircularProgressIndicator();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                          children: const [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  // value: .2,
                                  // strokeWidth: 3.0
                                  ),
                            ),
                            SizedBox(width: 10),
                            Text('Processing Data'),
                          ],
                        )));

                        await http.post(
                          Uri.parse('http://localhost:3000/api/register'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: convert.json.encode({
                            'username': _nameController.text,
                            'email': _emailController.text,
                            'psw': _passwordController.text,
                          }),
                        );
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

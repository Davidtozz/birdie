import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
           
          children: [
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction, 
                child: Column(
                  
                  children: <Widget>[
                    
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 300,
                      child: FormBuilderTextField(
                        maxLength: 50,
                        
                        name: 'email',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    )
 
                       


                     
                  ],
                ),
              
            ),
          ],
        ),
      ),
    );
  }
}

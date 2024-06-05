

import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool obscureText;
  const AuthWidget({super.key, required this.text, required this.controller, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(

      controller: controller,
      decoration: InputDecoration(
        hintText:text,
      ),
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: (String? value){
        if(value!.isEmpty){
          return '$text can not be empty';
        } else{
          return null;
        }
      },
    );
  }
}

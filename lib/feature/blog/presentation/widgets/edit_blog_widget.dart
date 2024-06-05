
import 'package:flutter/material.dart';

class EditBlogWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const EditBlogWidget({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      decoration: InputDecoration(
        hintText: text
      ),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$text is missing!';
        }
        return null;
      },
    );
  }
}

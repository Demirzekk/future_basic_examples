import 'package:flutter/material.dart';

class CustomTextFieldPass extends StatelessWidget {
  const CustomTextFieldPass(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.title,
      this.textValidator});
  final TextEditingController controller;
  final String hintText;
  final String title;
  final String? Function(String?)? textValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            validator: textValidator,
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            controller: controller,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.title,
      this.label,
      this.val,
      this.textController,
      this.maxLenght,
      this.onChanged,
      this.keywordtype,
      this.helperText});
  final String title;
  final String? label;
  final String? Function(String?)? val;
  final TextEditingController? textController;
  final int? maxLenght;
  final String? helperText;
  final TextInputType? keywordtype;
  final Function(String val)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLength: maxLenght,
      controller: textController,
      decoration: InputDecoration(
        hintText: title,
        helperText: helperText,
        label: Text(label ?? ""),
      ),
      validator: val,
      keyboardType: keywordtype,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.validator,
    this.controller,
    this.prefix,
    this.suffix,
    this.obscureText = false,
  }) : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        enabledBorder: border(Colors.teal),
        focusedBorder: border(Colors.teal),
        errorBorder: border(Colors.red),
        focusedErrorBorder: border(Colors.red),
      ),
      validator: validator,
    );
  }
}

OutlineInputBorder border(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: color,
    ),
  );
}

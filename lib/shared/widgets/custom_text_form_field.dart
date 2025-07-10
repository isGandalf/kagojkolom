import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool disabled;
  final bool isObscure;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.disabled, required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
      controller: controller,
      enabled: !disabled,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(hintText: hintText),
      obscureText: isObscure,
    );
  }
}

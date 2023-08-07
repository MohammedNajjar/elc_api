import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    required this.keyboardType,
    required this.prefixIcon,
    required this.controller,
    required this.obscurerText,
  });

  final String hint;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscurerText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscurerText,

      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8)),
          hintText: hint,
          label: Text(hint),
          prefixIcon: Icon(prefixIcon)),
    );
  }
}

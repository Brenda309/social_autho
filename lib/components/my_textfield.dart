import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];
    final fillColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
    final hintColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!),
          ),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
        ),
      ),
    );
  }
}

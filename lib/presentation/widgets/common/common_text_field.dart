import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? hintTextColor;
  final bool filled;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.borderColor,
    this.hintTextColor,
    this.filled = true,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor = borderColor ?? Colors.grey.shade300;
    final Color effectiveHintColor = hintTextColor ?? Colors.grey.shade400;
    final Color effectiveFillColor = fillColor ?? Colors.white;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: effectiveHintColor, fontSize: 15),
        filled: filled,
        fillColor: effectiveFillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: effectiveBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: effectiveBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: effectiveBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
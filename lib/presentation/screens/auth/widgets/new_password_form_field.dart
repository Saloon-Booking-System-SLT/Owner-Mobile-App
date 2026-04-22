import 'package:flutter/material.dart';

class NewPasswordFormField extends StatefulWidget {
  final TextEditingController controller;

  const NewPasswordFormField({super.key, required this.controller});

  @override
  State<NewPasswordFormField> createState() => _NewPasswordFormFieldState();
}

class _NewPasswordFormFieldState extends State<NewPasswordFormField> {
  bool _obscureNewPassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureNewPassword,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Enter New Password',
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF616161), // Black38
          ),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFFF0000),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFFF0000),
              width: 1.5,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade400,
            ),
            onPressed: () {
              setState(() {
                _obscureNewPassword = !_obscureNewPassword;
              });
            },
          ),
        ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a new password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      ),
    );
  }
}

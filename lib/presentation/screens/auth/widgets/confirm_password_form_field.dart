import 'package:flutter/material.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final String? errorText;
  final Function(String)? onChanged;

  const ConfirmPasswordFormField({
    super.key,
    required this.controller,
    required this.passwordController,
    this.errorText,
    this.onChanged,
  });

  @override
  State<ConfirmPasswordFormField> createState() => _ConfirmPasswordFormFieldState();
}

class _ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.errorText != null
                  ? Colors.red
                  : const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureConfirmPassword,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: 'Confirm Your Password',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBDBDBD),
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade400,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}

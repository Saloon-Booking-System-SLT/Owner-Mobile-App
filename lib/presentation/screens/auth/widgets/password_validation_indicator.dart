import 'package:flutter/material.dart';

class PasswordValidationIndicator extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const PasswordValidationIndicator({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  State<PasswordValidationIndicator> createState() => _PasswordValidationIndicatorState();
}

class _PasswordValidationIndicatorState extends State<PasswordValidationIndicator> {
  bool isMinimumLength = false;
  bool isPasswordMatch = false;

  @override
  void initState() {
    super.initState();
    widget.newPasswordController.addListener(_validatePassword);
    widget.confirmPasswordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    widget.newPasswordController.removeListener(_validatePassword);
    widget.confirmPasswordController.removeListener(_validatePassword);
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      isMinimumLength = widget.newPasswordController.text.length >= 6;
      isPasswordMatch = widget.newPasswordController.text.isNotEmpty &&
          widget.newPasswordController.text == widget.confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildValidationItem('At least 6 characters', isMinimumLength),
        const SizedBox(height: 12),
        _buildValidationItem('Passwords match', isPasswordMatch),
      ],
    );
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: isValid ? Colors.green : Colors.grey.shade400,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isValid ? Colors.black : Colors.black54,
            fontWeight: isValid ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

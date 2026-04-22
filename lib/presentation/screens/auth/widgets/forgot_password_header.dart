import 'package:flutter/material.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // SizedBox(height: 16),
        Text(
          'Enter your phone number to receive',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        Text(
          'a verification code',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

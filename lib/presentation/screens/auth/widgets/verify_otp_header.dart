import 'package:flutter/material.dart';

class VerifyOtpHeader extends StatelessWidget {
  const VerifyOtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 8),
        Text(
          'Enter the 4-digit code sent to your phone',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
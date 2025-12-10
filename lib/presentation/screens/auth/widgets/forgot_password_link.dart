import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/forgot_password.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigate to Forgot Password screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            ),
          );
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1565C0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

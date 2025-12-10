import 'package:flutter/material.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to login screen
            Navigator.pop(context);
          },
          child: const Text(
            'Login here',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1565C0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

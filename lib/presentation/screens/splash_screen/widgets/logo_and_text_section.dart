import 'package:flutter/material.dart';

class LogoAndTextSection extends StatelessWidget {
  const LogoAndTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main logo
        Image.asset('assets/images/logo.png', width: 200, height: 200),
        const SizedBox(height: 20),
        // eSalon text
        const Text(
          'eSalon',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        // Subtitle text
        const Text(
          'Find Your Perfect Hair\nSalon',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1976D2),
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

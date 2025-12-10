import 'package:flutter/material.dart';

class BottomLogo extends StatelessWidget {
  const BottomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Image.asset(
        'assets/images/slt_logo.png',
        width: 180,
        height: 80,
      ),
    );
  }
}

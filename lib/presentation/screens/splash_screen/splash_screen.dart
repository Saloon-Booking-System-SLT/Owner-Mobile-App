import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/lang/select_language.dart';
import 'package:owner_salon_management/presentation/screens/splash_screen/widgets/bottom_logo.dart';
import 'package:owner_salon_management/presentation/screens/splash_screen/widgets/logo_and_text_section.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Language Selection screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LanguageSelectionScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: Column(
        children: [
          const Spacer(flex: 2),
          // Logo and text section
          const Center(
            child: LogoAndTextSection(),
          ),
          const Spacer(flex: 2),
          // SLT Mobitel logo at bottom
          const BottomLogo(),
        ],
      ),
    );
  }
}

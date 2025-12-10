import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/login_screen.dart';
import 'package:owner_salon_management/presentation/screens/lang/widgets/get_started_button.dart';
import 'package:owner_salon_management/presentation/screens/lang/widgets/language_header.dart';
import 'package:owner_salon_management/presentation/screens/lang/widgets/language_list_view.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English';
  final Map<String, String> languages = {
    'English': 'English',
    'Sinhala': 'සිංහල',
    'Tamil': 'தமிழ்',
  };

  void _onGetStarted() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              const LanguageHeader(),
              const SizedBox(height: 40),
              LanguageListView(
                selectedLanguage: selectedLanguage,
                languages: languages,
                onLanguageSelected: (language) {
                  setState(() {
                    selectedLanguage = language;
                  });
                },
              ),
              const Spacer(),
              GetStartedButton(onPressed: _onGetStarted),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}


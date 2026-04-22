import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/forgot_password_app_bar.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/forgot_password_header.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/login_link.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/phone_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/send_otp_button.dart';
import 'verify_otp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ForgotPasswordAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30), // Add spacing from top
                const ForgotPasswordHeader(),
                const SizedBox(height: 60),
                PhoneFormField(controller: phoneController),
                const SizedBox(height: 24),
                SendOtpButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifyOtpScreen(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                const LoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
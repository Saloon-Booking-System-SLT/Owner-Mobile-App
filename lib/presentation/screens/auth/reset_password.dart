import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/confirm_password_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/new_password_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/password_validation_indicator.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/reset_password_app_bar.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/reset_password_button.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/reset_password_header.dart';
import '../../../app_main_page.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: const ResetPasswordAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: ResetPasswordHeader(),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: NewPasswordFormField(controller: newPasswordController),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: ConfirmPasswordFormField(
                      controller: confirmPasswordController,
                      passwordController: newPasswordController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PasswordValidationIndicator(
                    newPasswordController: newPasswordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  const SizedBox(height: 40),
                  ResetPasswordButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password reset successful!'),
                            backgroundColor: Color(0xFF4CAF50),
                          ),
                        );
                        // Navigate to dashboard after successful password reset
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const SalonMainApp()),
                            (route) => false,
                          );
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
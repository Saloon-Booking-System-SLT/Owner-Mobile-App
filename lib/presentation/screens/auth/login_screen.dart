import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/register.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/forgot_password_link.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/email_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/password_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/login_button.dart';
import '../../../app_main_page.dart';
import '../../../data/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  void _handleLogin() async {
    try {
      final resp = await AuthService.login(
        _emailController.text,
        _passwordController.text,
      );
      // check approvalStatus
      final salon = resp['salon'];
      final approvalStatus = salon['approvalStatus'];
      if (!mounted) return;
      if (approvalStatus != null && approvalStatus != 'approved') {
        // show message to user about pending approval
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SalonMainApp()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _handleRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Login to your salon',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Manage appointments\nand services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  EmailFormField(
                    controller: _emailController,
                    errorText: _emailError,
                    onChanged: (value) {
                      if (_emailError != null) {
                        setState(() {
                          _emailError = _validateEmail(value);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordFormField(
                    controller: _passwordController,
                    errorText: _passwordError,
                    onChanged: (value) {
                      if (_passwordError != null) {
                        setState(() {
                          _passwordError = _validatePassword(value);
                        });
                      }
                    },
                  ),

                  const ForgotPasswordLink(),
                  const SizedBox(height: 20),
                  LoginButton(onPressed: _handleLogin),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not registered yet? ',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: _handleRegister,
                          child: const Text(
                            'Register here',
                            style: TextStyle(
                              color: Color(0xFF0D5FB3),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

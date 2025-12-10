import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/login_screen.dart';
import 'package:owner_salon_management/presentation/screens/auth/set_up_account.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/email_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/password_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/confirm_password_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/phone_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/next_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _phoneError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
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

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces and special characters for validation
    final cleanedPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanedPhone.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (!RegExp(r'^[0-9+]+$').hasMatch(cleanedPhone)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  void _handleNext() {
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
      _confirmPasswordError = _validateConfirmPassword(_confirmPasswordController.text);
      _phoneError = _validatePhone(_phoneController.text);
    });

    if (_emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _phoneError == null) {
      // All validations passed - proceed to next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetupAccountScreen(
            email: _emailController.text,
            password: _passwordController.text,
            phone: _phoneController.text,
          ),
        ),
      );

    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before continuing'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
        'Create Your Salon Account',
        style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.2,
    ),),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Set up your account to manage\n bookings and services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.4,
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
                      // Also revalidate confirm password if it has been filled
                      if (_confirmPasswordController.text.isNotEmpty && _confirmPasswordError != null) {
                        setState(() {
                          _confirmPasswordError = _validateConfirmPassword(_confirmPasswordController.text);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ConfirmPasswordFormField(
                    controller: _confirmPasswordController,
                    passwordController: _passwordController,
                    errorText: _confirmPasswordError,
                    onChanged: (value) {
                      if (_confirmPasswordError != null) {
                        setState(() {
                          _confirmPasswordError = _validateConfirmPassword(value);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  PhoneFormField(
                    controller: _phoneController,
                    errorText: _phoneError,
                    onChanged: (value) {
                      if (_phoneError != null) {
                        setState(() {
                          _phoneError = _validatePhone(value);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  NextButton(
                    onPressed: _handleNext,
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
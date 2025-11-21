import 'package:flutter/material.dart';
import 'package:salon_slt/core/responsive/extensions.dart';
import 'package:salon_slt/core/theme/colors.dart';
import 'package:salon_slt/presentation/screens/auth/register.dart';
import 'package:salon_slt/presentation/screens/home/dashboardscreen.dart';
import '../../../core/responsive/app_size.dart';
import '../../../core/responsive/size_config.dart';
import '../../../core/responsive/spacing.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  void _handleRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize size config
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xl.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login to your salon',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Spacing.sm.h),

                    Text(
                      'Manage appointments\nand services',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),

                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Enter Your Email',
                      hintTextColor: AppColors.textPlaceholder,
                      keyboardType: TextInputType.emailAddress,
                      borderColor: AppColors.placeholderBorder,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Spacing.md.h),

                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Enter Your Password',
                      hintTextColor: AppColors.textPlaceholder,
                      keyboardType: TextInputType.visiblePassword,
                      borderColor: AppColors.placeholderBorder,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Spacing.lg.h),

                    CustomButton(
                      onPressed: _handleLogin,
                      backgroundColor: AppColors.buttonPrimary,
                      width: double.infinity,
                      height: AppSizes.inputHeight,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not registered yet?  ',
                          style: TextStyle(
                            color: AppColors.gray50,
                            fontSize: 12.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleRegister,
                          child: Text(
                            'Register here',
                            style: TextStyle(
                              color: AppColors.textBlue,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/verify_otp_app_bar.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/verify_otp_header.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/otp_input_fields.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/verify_button.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/resend_otp_timer.dart';
import 'reset_password.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  bool _canResend = false;
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    // Add listener to move focus to next field
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1 && i < controllers.length - 1) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    if (_canResend) {
      setState(() {
        _canResend = false;
        _resendTimer = 30;
      });
      _startResendTimer();
      // TODO: Implement resend OTP logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP has been resent')),
      );
    }
  }

  void _verifyOtp() {
    String otp = controllers.map((c) => c.text).join();
    // TODO: Implement OTP verification logic
    if (otp.length == 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VerifyOtpAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 24), // Spacing from top
                VerifyOtpHeader(),
                const SizedBox(height: 60),
                OtpInputFields(
                  controllers: controllers,
                  focusNodes: focusNodes,
                ),
                const SizedBox(height: 40),
                VerifyButton(onPressed: _verifyOtp),
                const SizedBox(height: 24),
                ResendOtpTimer(
                  canResend: _canResend,
                  resendTimer: _resendTimer,
                  onResend: _resendOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
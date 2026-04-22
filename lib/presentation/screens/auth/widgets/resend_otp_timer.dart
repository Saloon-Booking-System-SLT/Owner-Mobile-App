import 'package:flutter/material.dart';

class ResendOtpTimer extends StatelessWidget {
  final bool canResend;
  final int resendTimer;
  final VoidCallback onResend;

  const ResendOtpTimer({
    super.key,
    required this.canResend,
    required this.resendTimer,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive the code? ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        if (canResend)
          GestureDetector(
            onTap: onResend,
            child: const Text(
              'Resend',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Text(
            'Resend in $resendTimer s',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1565C0),
            ),
          ),
      ],
    );
  }
}
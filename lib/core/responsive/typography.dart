import 'package:flutter/material.dart';
import 'extensions.dart';
import '../theme/colors.dart';

class AppTypography {
  static TextStyle h1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );
}
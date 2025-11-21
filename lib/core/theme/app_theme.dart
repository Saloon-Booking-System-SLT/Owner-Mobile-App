
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // 1. Base color scheme generated from your primary brand color
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),

    // 2. Global overrides using your custom brand colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,

    // 3. Global typography
    fontFamily: "Poppins",
  );
}
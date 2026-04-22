import 'package:flutter/material.dart';
import 'package:salon_slt/core/responsive/extensions.dart';
import 'package:salon_slt/presentation/screens/auth/login.dart';
import '../../../core/responsive/size_config.dart';
import '../../../core/responsive/spacing.dart';
import '../../../core/theme/colors.dart';
import '../../widgets/common/common_button.dart';


class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Language",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: Spacing.sm),
                Text(
                  "Choose your preferred language to continue",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 40.h),

                CustomButton(
                  onPressed: () {
                    setState(() {
                      selectedLanguage = 'English';
                    });
                  },
                  backgroundColor: selectedLanguage == 'English'
                      ? AppColors.buttonPrimary
                      : AppColors.white,
                  borderColor: AppColors.borderPrimary,
                  child: Text(
                    "English",
                    style: TextStyle(
                      color: selectedLanguage == 'English'
                          ? AppColors.text5
                          : AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: Spacing.md),

                CustomButton(
                  onPressed: () {
                    setState(() {
                      selectedLanguage = 'Sinhala';
                    });
                  },
                  borderColor: AppColors.borderPrimary,
                  backgroundColor: selectedLanguage == 'Sinhala'
                      ? AppColors.buttonPrimary
                      : AppColors.white,
                  child: Text(
                    "සිංහල",
                    style: TextStyle(
                      color: selectedLanguage == 'Sinhala'
                          ? AppColors.text5
                          : AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: Spacing.md),

                CustomButton(
                  onPressed: () {
                    setState(() {
                      selectedLanguage = 'Tamil';
                    });
                  },
                  borderColor: AppColors.borderPrimary,
                  backgroundColor: selectedLanguage == 'Tamil'
                      ? AppColors.buttonPrimary
                      : AppColors.white,
                  child: Text(
                    "தமிழ்",
                    style: TextStyle(
                      color: selectedLanguage == 'Tamil'
                          ? AppColors.text5
                          : AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 250.h),

                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  backgroundColor: AppColors.buttonPrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get started",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: Spacing.sm),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
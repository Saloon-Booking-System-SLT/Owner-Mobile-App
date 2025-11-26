import 'package:flutter/material.dart';
import 'dart:io';

import 'package:salon_slt/presentation/screens/auth/successscreen.dart';

import '../../../core/theme/colors.dart';

class UploadSalonImageScreen extends StatefulWidget {
  const UploadSalonImageScreen({super.key});

  @override
  State<UploadSalonImageScreen> createState() => _UploadSalonImageScreenState();
}

class _UploadSalonImageScreenState extends State<UploadSalonImageScreen> {
  File? _selectedImage;
  String? _selectedFileName;

  void _handleBack() {
    Navigator.pop(context);
  }

  void _handleChooseFile() {
    // Simulate file selection
    setState(() {
      _selectedFileName = 'Salonimg.jpg';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File selection dialog would open here')),
    );
  }

  void _handleTapToUpload() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker would open here')),
    );
  }

  void _handleFinishSetup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AccountSuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: _handleBack,
        ),
        title: const Text(
          'Set up Your Account',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            
            // Upload Salon Image Label
            Text(
              'Upload Salon Image',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            
            // Upload Container
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.borderImage,
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cloud upload icon
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: AppColors.black,
                  ),
                  const SizedBox(height: 12),
                  
                  // Tap to upload text
                  GestureDetector(
                    onTap: _handleTapToUpload,
                    child: const Text(
                      'Tap to upload photo',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2196F3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.divider,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.divider,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.divider,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Choose file button and file name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Choose file button
                      OutlinedButton(
                        onPressed: _handleChooseFile,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.black,
                          side: BorderSide(color: AppColors.borderCard),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        child: const Text(
                          'Choose file',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // File name
                      Text(
                        _selectedFileName ?? 'No file chosen',
                        style: TextStyle(
                          fontSize: 13,
                          color: _selectedFileName != null 
                              ? AppColors.black
                              : AppColors.gray50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Finish Setup Button
            ElevatedButton(
              onPressed: _handleFinishSetup,
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.buttonPrimary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Finish Setup',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
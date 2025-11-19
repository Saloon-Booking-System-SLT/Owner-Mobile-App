import 'package:flutter/material.dart';
import 'dart:io';

import 'package:salon_slt/presentation/screens/auth/successscreen.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: _handleBack,
        ),
        title: const Text(
          'Set up Your Account',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            
            // Upload Salon Image Label
            Text(
              'Upload Salon Image',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            
            // Upload Container
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
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
                    color: Colors.grey[600],
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
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
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
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey[400]!),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Choose file',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
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
                              ? Colors.black87 
                              : Colors.grey[500],
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
                backgroundColor: const Color(0xFF0D5EAC),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Finish Setup',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
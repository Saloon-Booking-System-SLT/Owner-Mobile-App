import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/file_info_display.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/finish_setup_button.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/image_picker_box.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/upload_image_app_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/auth_service.dart';
import 'login_screen.dart';

class UploadSalonImageScreen extends StatefulWidget {
  final String ownerEmail;
  final String ownerPassword;
  final String phoneNumber;

  final String salonName;
  final String location;
  final String salonType;

  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const UploadSalonImageScreen({
    super.key,
    required this.ownerEmail,
    required this.ownerPassword,
    required this.phoneNumber,
    required this.salonName,
    required this.location,
    required this.salonType,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<UploadSalonImageScreen> createState() => _UploadSalonImageScreenState();
}

class _UploadSalonImageScreenState extends State<UploadSalonImageScreen> {
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();

  // … inside _finishSetup()
  Future<void> _finishSetup() async {
    if (selectedImage == null) {
      _showErrorSnackBar('Please select an image');
      return;
    }

    final fields = <String, String>{
      'name': widget.salonName,
      'email': widget.ownerEmail,
      'password': widget.ownerPassword,
      'phone': widget.phoneNumber,
      'location': widget.location,
      'salonType': widget.salonType,
      'workingHours': jsonEncode({
        'start': widget.startTime.format(context),
        'end': widget.endTime.format(context),
      }),
      'services': jsonEncode(['Cut', 'Color']),
      'coordinates': jsonEncode({'lat': 6.9271, 'lng': 79.8612}),
    };

    try {
      await AuthService.registerWithImage(
        fields: fields,
        imageFile: selectedImage,
      );
      // result contains token, salon etc.
      if (!mounted) return;
      _showSuccessSnackBar('Setup completed successfully!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar(e.toString());
    }
  }

  Future<void> _showImageSourceDialog() async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Image Source',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // Camera Option
                  Expanded(
                    child: _ImageSourceOption(
                      icon: Icons.camera_alt_outlined,
                      label: 'Camera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Gallery Option
                  Expanded(
                    child: _ImageSourceOption(
                      icon: Icons.photo_library_outlined,
                      label: 'Gallery',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Cancel Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          selectedImage = image;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      _showErrorSnackBar('Failed to pick image. Please try again.');
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UploadImageAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add a professional photo of your salon to attract more customers',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ImagePickerBox(
                      selectedImage: selectedImage,
                      onImageSelected: (image) {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    FileInfoDisplay(
                      selectedImage: selectedImage,
                      onChooseFile: _showImageSourceDialog,
                    ),
                    const SizedBox(height: 24),
                    // Image Guidelines
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF1565C0).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF1565C0),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Image Guidelines',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1565C0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• High-quality, well-lit photos\n• Show your salon\'s interior or exterior\n• No text or logos overlaid on image\n• Recommended size: 1080x720 pixels',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FinishSetupButton(onPressed: _finishSetup),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF1565C0).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF1565C0).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF1565C0), size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

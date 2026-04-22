import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../data/models/staff_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/staff_service.dart';

class AddStaffScreen extends StatefulWidget {
  final List<String> availableServices;
  final StaffModel? existingStaff;

  const AddStaffScreen({
    Key? key,
    required this.availableServices,
    this.existingStaff,
  }) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _servicesController = TextEditingController();
  final _availabilityController = TextEditingController();
  final _workingHoursController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String _selectedGender = 'Male';
  XFile? _selectedImage;
  XFile? _selectedCertificate;
  String? _imageFileName;
  String? _certificateFileName;
  List<String> _selectedServices = [];

  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _availabilityOptions = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingStaff != null) {
      final staff = widget.existingStaff!;
      _nameController.text = staff.name;
      _selectedGender = staff.gender;
      _selectedServices = List.from(staff.services);
      _servicesController.text = _selectedServices.join(', ');
      _availabilityController.text = staff.availability;
      _workingHoursController.text = staff.workingHours;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _servicesController.dispose();
    _availabilityController.dispose();
    _workingHoursController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
          _imageFileName = image.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _selectedImage = photo;
          _imageFileName = photo.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickCertificate() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        setState(() {
          _selectedCertificate = file;
          _certificateFileName = file.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking certificate: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF0BA5E9),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF0BA5E9)),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showServicesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelected = List.from(_selectedServices);
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Select Services'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.availableServices.map((service) {
                    return CheckboxListTile(
                      title: Text(service),
                      value: tempSelected.contains(service),
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            tempSelected.add(service);
                          } else {
                            tempSelected.remove(service);
                          }
                        });
                      },
                      activeColor: Colors.blue.shade900,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedServices = tempSelected;
                      _servicesController.text = _selectedServices.join(', ');
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                  ),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAvailabilityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelected = _availabilityController.text.isEmpty
            ? []
            : _availabilityController.text.split(', ');
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Select Availability'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _availabilityOptions.map((day) {
                    return CheckboxListTile(
                      title: Text(day),
                      value: tempSelected.contains(day),
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            tempSelected.add(day);
                          } else {
                            tempSelected.remove(day);
                          }
                        });
                      },
                      activeColor: Colors.blue.shade900,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _availabilityController.text = tempSelected.join(', ');
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                  ),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _imageFileName = null;
    });
  }

  void _removeCertificate() {
    setState(() {
      _selectedCertificate = null;
      _certificateFileName = null;
    });
  }

  bool _isSubmitting = false;

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedServices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one service'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => _isSubmitting = true);

      try {
        final profile = await AuthService.getOwnerProfile();
        final salonId = profile['salon'] != null 
            ? profile['salon']['id'] 
            : profile['_id'];

        if (salonId == null) throw Exception('Salon ID not found');

        final staff = StaffModel(
          id: widget.existingStaff?.id,
          name: _nameController.text.trim(),
          gender: _selectedGender,
          isAvailable: true,
          services: _selectedServices,
          availability: _availabilityController.text.trim(),
          workingHours: _workingHoursController.text.trim(),
        );

        final StaffModel result;
        if (widget.existingStaff != null) {
          result = await StaffService.updateStaff(
            widget.existingStaff!.id!,
            staff,
            imageFile: _selectedImage,
            certificateFile: _selectedCertificate,
          );
        } else {
          result = await StaffService.addStaff(
            staff,
            salonId,
            imageFile: _selectedImage,
            certificateFile: _selectedCertificate,
          );
        }

        if (mounted) {
          Navigator.of(context).pop(result);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add professional: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.existingStaff != null ? 'Edit Professional' : 'Add Professional',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF1A1A1A),
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter professional name',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Select Gender',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    items: _genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _servicesController,
                    readOnly: true,
                    onTap: _showServicesDialog,
                    decoration: InputDecoration(
                      labelText: 'Service Provided',
                      hintText: 'Select services',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select services';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _availabilityController,
                    readOnly: true,
                    onTap: _showAvailabilityDialog,
                    decoration: InputDecoration(
                      labelText: 'Availability',
                      hintText: 'Select available days',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select availability';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _workingHoursController,
                    decoration: InputDecoration(
                      labelText: 'Working Hours',
                      hintText: 'e.g., 9:00 AM - 6:00 PM',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter working hours';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Image Picker Section
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: _selectedImage != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: kIsWeb
                                    ? Image.network(
                                        _selectedImage!.path,
                                        height: 140,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(_selectedImage!.path),
                                        height: 140,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade500,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: _removeImage,
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        _imageFileName ?? 'Image selected',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: _showImageSourceDialog,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF0BA5E9,
                                      ).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add_photo_alternate_rounded,
                                      size: 40,
                                      color: Color(0xFF0BA5E9),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Add Service Image',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF1A1A1A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Gallery or Camera',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 24),
                  const Text(
                    'Upload Certificate',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: _selectedCertificate != null
                        ? ListTile(
                            leading: const Icon(
                              Icons.insert_drive_file,
                              color: Color(0xFF0BA5E9),
                              size: 32,
                            ),
                            title: Text(
                              _certificateFileName ?? 'Certificate',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: _removeCertificate,
                            ),
                          )
                        : InkWell(
                            onTap: _pickCertificate,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.upload_file,
                                      color: Colors.grey.shade600,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Choose File',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'No file chosen',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1A1A1A),
                            side: const BorderSide(color: Color(0xFFE0E0E0)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  widget.existingStaff != null ? 'Update' : 'Add',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

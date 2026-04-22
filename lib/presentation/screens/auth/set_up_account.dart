import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owner_salon_management/presentation/screens/auth/image_screen.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/location_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/interactive_map_picker.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/salon_name_form_field.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/salon_type_dropdown.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/setup_account_next_button.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/working_hours_picker.dart';

class SetupAccountScreen extends StatefulWidget {
  final String email;
  final String password;
  final String phone;

  const SetupAccountScreen({
    super.key,
    required this.email,
    required this.password,
    required this.phone,
  });


  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedSalonType;
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 19, minute: 0);
  bool _isSubmitting = false;
  LatLng? _selectedLocation;
  String? _selectedAddress;

  final List<String> salonTypes = [
    'Unisex',
    'Men Only',
    'Women Only',
    'Kids Salon',
    'Spa & Wellness',
  ];

  @override
  void dispose() {
    salonNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _onLocationSelected(LatLng location, String address) {
    setState(() {
      _selectedLocation = location;
      _selectedAddress = address;
      locationController.text = address;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedSalonType == null) {
      _showErrorSnackBar('Please select a salon type');
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate processing
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadSalonImageScreen(
          ownerEmail: widget.email,
          ownerPassword: widget.password,
          phoneNumber: widget.phone,
          salonName: salonNameController.text,
          location: locationController.text,
          salonType: selectedSalonType!,
          startTime: startTime,
          endTime: endTime,
        ),
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
        title: const Text(
          'Setup Your Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  SalonNameFormField(controller: salonNameController),
                  const SizedBox(height: 24),
                  SalonTypeDropdown(
                    selectedSalonType: selectedSalonType,
                    onChanged: (value) => setState(() => selectedSalonType = value),
                    salonTypes: salonTypes,
                  ),
                  const SizedBox(height: 24),
                  WorkingHoursPicker(
                    startTime: startTime,
                    endTime: endTime,
                    onStartTimeChanged: (time) => setState(() => startTime = time),
                    onEndTimeChanged: (time) => setState(() => endTime = time),
                  ),
                  const SizedBox(height: 24),
                  LocationFormField(controller: locationController),
                  const SizedBox(height: 16),
                  InteractiveMapPicker(
                    onLocationSelected: _onLocationSelected,
                    initialLocation: _selectedLocation,
                    initialAddress: _selectedAddress,
                  ),
                  const SizedBox(height: 40),
                  SetupAccountNextButton(
                    isSubmitting: _isSubmitting,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
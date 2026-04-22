import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../auth/widgets/salon_name_form_field.dart';
import '../auth/widgets/location_form_field.dart';
import '../auth/widgets/working_hours_picker.dart';
import '../auth/widgets/salon_type_dropdown.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> salonData;
  const EditProfilePage({Key? key, required this.salonData}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 19, minute: 0);
  String? selectedSalonType;
  final List<String> salonTypes = [
    'Unisex',
    'Men Only',
    'Women Only',
    'Kids Salon',
    'Spa & Wellness',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.salonData['name'] ?? '',
    );
    emailController = TextEditingController(
      text: widget.salonData['email'] ?? '',
    );
    locationController = TextEditingController(
      text: widget.salonData['location'] ?? '',
    );
    final type = widget.salonData['salonType'];
    if (type is String && salonTypes.contains(type)) {
      selectedSalonType = type;
    } else {
      selectedSalonType = null;
    }
    final workingHoursRaw = widget.salonData['workingHours'] ?? '';
    String start = '';
    String end = '';
    if (workingHoursRaw is Map<String, dynamic>) {
      start = workingHoursRaw['start'] ?? '';
      end = workingHoursRaw['end'] ?? '';
    } else if (workingHoursRaw is String) {
      final parts = workingHoursRaw.split('-');
      if (parts.isNotEmpty) start = parts[0].trim();
      if (parts.length > 1) end = parts[1].trim();
    }
    // parse times like "09:00 am", "9:00pm", or "09:00"
    TimeOfDay? parseTimeString(Object? value, {required TimeOfDay fallback}) {
      if (value is! String || value.trim().isEmpty) return fallback;
      final s = value.trim().toLowerCase();
      final regex = RegExp(r'^(\d{1,2}):(\d{2})(?:\s*([ap]m))?$');
      final m = regex.firstMatch(s);
      if (m != null) {
        int h = int.tryParse(m.group(1)!) ?? fallback.hour;
        final int min = int.tryParse(m.group(2)!) ?? fallback.minute;
        final String? period = m.group(3);
        if (period != null) {
          if (period == 'pm' && h != 12) h = (h % 12) + 12;
          if (period == 'am' && h == 12) h = 0;
        }
        return TimeOfDay(hour: h, minute: min);
      }
      return fallback;
    }

    startTime = parseTimeString(start, fallback: startTime) ?? startTime;
    endTime = parseTimeString(end, fallback: endTime) ?? endTime;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  bool _isSaving = false;

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    try {
      final id = widget.salonData['id'] ?? widget.salonData['_id'];
      if (id == null) throw Exception('Salon ID not found');
      String formatTime(TimeOfDay t) {
        final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
        final hourStr = hour.toString().padLeft(2, '0');
        final minute = t.minute.toString().padLeft(2, '0');
        final period = t.period == DayPeriod.am ? 'am' : 'pm';
        return '$hourStr:$minute $period';
      }

      await AuthService.updateOwnerProfile(
        id: id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        location: locationController.text.trim(),
        salonType: selectedSalonType,
        workingHoursStart: formatTime(startTime),
        workingHoursEnd: formatTime(endTime),
      );
      if (mounted) {
        // Update local salonData so dropdown shows new value if page is reopened
        widget.salonData['salonType'] = selectedSalonType;
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        ),
        title: const Text(
          'Edit Profile',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                SalonNameFormField(controller: nameController),
                const SizedBox(height: 16),
                // Email field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SalonTypeDropdown(
                  selectedSalonType: selectedSalonType,
                  onChanged: (value) =>
                      setState(() => selectedSalonType = value),
                  salonTypes: salonTypes,
                ),
                const SizedBox(height: 16),
                WorkingHoursPicker(
                  startTime: startTime,
                  endTime: endTime,
                  onStartTimeChanged: (time) =>
                      setState(() => startTime = time),
                  onEndTimeChanged: (time) => setState(() => endTime = time),
                ),
                const SizedBox(height: 16),
                LocationFormField(controller: locationController),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

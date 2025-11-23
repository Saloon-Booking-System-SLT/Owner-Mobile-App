import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_text_field.dart';
import 'imageupload.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key});

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  final TextEditingController _salonNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController(
    // text: 'High level road, Maharagama, Sri Lanka',
  );
  final _formKey = GlobalKey<FormState>();

  String? _selectedSalonType;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 19, minute: 0);

  final List<String> _salonTypes = [
    'Unisex',
    'Men\'s Salon',
    'Women\'s Salon',
    'Spa & Salon',
  ];

  @override
  void dispose() {
    _salonNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _handleBack() {
    Navigator.pop(context);
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UploadSalonImageScreen()),
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '$hour.$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Salon Name
                Text(
                  'Salon Name',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _salonNameController,
                  hintText: 'Enter Your Salon Name',
                  hintTextColor: AppColors.textPlaceholder,
                  borderColor: AppColors.placeholderBorder,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter salon name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Salon Type
                Text(
                  'Salon Type',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedSalonType,
                  hint: Text(
                    'Select Salon type Ex: Unisex',
                    style: TextStyle(
                      color: AppColors.textPlaceholder,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.textPlaceholder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.textPlaceholder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.textPlaceholder,
                      ),
                    ),
                  ),
                  dropdownColor: AppColors.white,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textPrimary,
                  ),
                  items:
                      _salonTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSalonType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select salon type';
                    }
                    return null;
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return _salonTypes.map((String type) {
                      return Text(
                        type,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      );
                    }).toList();
                  },
                ),
                const SizedBox(height: 20),

                // Working Hours
                Text(
                  'Working Hours',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectTime(context, true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.textPlaceholder,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatTime(_startTime),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textPlaceholder,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectTime(context, false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.textPlaceholder,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatTime(_endTime),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textPlaceholder,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Set Your Salon Location
                Text(
                  'Set Your Salon Location',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _locationController,
                  hintText: 'Enter location',
                  hintTextColor: AppColors.textPlaceholder,
                  borderColor: AppColors.textPlaceholder,
                ),
                const SizedBox(height: 8),

                // Map instruction
                Text(
                  'Click on the map to pick location',
                  style: TextStyle(fontSize: 12, color: AppColors.text4),
                ),
                const SizedBox(height: 12),

                // Map placeholder
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.gray50),
                  ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Image.network(
                          'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/79.8612,6.9271,10,0/600x500@2x?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.gray50,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.map,
                                      size: 48,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Map View',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Center(
                          child: Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                CustomButton(
                  onPressed: _handleNext,
                  backgroundColor: AppColors.buttonPrimary,
                  width: double.infinity,
                  height: 40,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

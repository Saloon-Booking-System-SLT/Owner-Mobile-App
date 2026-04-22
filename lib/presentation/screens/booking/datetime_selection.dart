import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_salon_management/data/services/booking_service.dart';
import 'package:owner_salon_management/data/models/staff_model.dart';
import 'package:owner_salon_management/data/models/service_model.dart';
import 'appoinment_summary.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final String salonId;
  final String customerName;
  final String customerPhoneNumber;
  final String customerEmail;
  final List<ServiceModel> selectedServices;
  final StaffModel selectedProfessional;

  const DateTimeSelectionScreen({
    super.key,
    required this.salonId,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerEmail,
    required this.selectedServices,
    required this.selectedProfessional,
  });

  @override
  State<DateTimeSelectionScreen> createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeSlotModel? _selectedTimeSlot;
  List<TimeSlotModel> _timeSlots = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTimeSlots();
  }

  Future<void> _loadTimeSlots() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
        _selectedTimeSlot = null;
      });

      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

      // Use the professional's ID (non-nullable, since it's required in the model)
      final professionalId = widget.selectedProfessional.id ?? '';

      if (professionalId.isEmpty) {
        throw Exception('Professional ID is missing');
      }

      final slots = await BookingService.fetchAvailableTimeSlots(
        professionalId: professionalId,
        date: formattedDate,
      );

      setState(() {
        _timeSlots = slots;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load time slots: $e';
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadTimeSlots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Date & Time',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a Date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildDateSelector(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Available Time slots',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_errorMessage.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red.shade900),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _loadTimeSlots,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade900,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else if (_timeSlots.isEmpty && !_isLoading)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'No available time slots for this date. Please select another date.',
                        style: TextStyle(color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    _buildTimeSlots(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedTimeSlot != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentSummaryScreen(
                              salonId: widget.salonId,
                              customerName: widget.customerName,
                              customerPhoneNumber: widget.customerPhoneNumber,
                              customerEmail: widget.customerEmail,
                              selectedServices: widget.selectedServices,
                              selectedProfessional: widget.selectedProfessional,
                              selectedDate: _selectedDate,
                              selectedTimeSlot: _selectedTimeSlot!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(_selectedDate),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_month, size: 20, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: _timeSlots.length,
      itemBuilder: (context, index) {
        final slot = _timeSlots[index];
        final isSelected = _selectedTimeSlot?.id == slot.id;
        return _buildTimeSlotChip(slot, isSelected);
      },
    );
  }

  Widget _buildTimeSlotChip(TimeSlotModel slot, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedTimeSlot?.id == slot.id) {
            _selectedTimeSlot = null;
          } else {
            _selectedTimeSlot = slot;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue.shade900 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            slot.startTime,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

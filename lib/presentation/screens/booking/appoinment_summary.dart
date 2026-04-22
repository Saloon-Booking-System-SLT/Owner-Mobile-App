import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_salon_management/data/services/booking_service.dart';
import 'package:owner_salon_management/data/models/staff_model.dart';
import 'package:owner_salon_management/data/models/service_model.dart';

class AppointmentSummaryScreen extends StatefulWidget {
  final String salonId;
  final String customerName;
  final String customerPhoneNumber;
  final String customerEmail;
  final List<ServiceModel> selectedServices;
  final StaffModel selectedProfessional;
  final DateTime selectedDate;
  final TimeSlotModel selectedTimeSlot;

  const AppointmentSummaryScreen({
    super.key,
    required this.salonId,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerEmail,
    required this.selectedServices,
    required this.selectedProfessional,
    required this.selectedDate,
    required this.selectedTimeSlot,
  });

  @override
  State<AppointmentSummaryScreen> createState() =>
      _AppointmentSummaryScreenState();
}

class _AppointmentSummaryScreenState extends State<AppointmentSummaryScreen> {
  bool _isBooking = false;

  double get totalPrice {
    return widget.selectedServices.fold(0.0, (sum, s) => sum + s.price);
  }

  String get totalDuration {
    final totalMinutes = widget.selectedServices.fold(
      0,
      (sum, s) => sum + s.duration,
    );
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours hour${hours > 1 ? 's' : ''} $minutes min${minutes > 1 ? 's' : ''}';
    } else if (hours > 0) {
      return '$hours hour${hours > 1 ? 's' : ''}';
    } else {
      return '$minutes min${minutes > 1 ? 's' : ''}';
    }
  }

  Future<void> _confirmAppointment() async {
    if (_isBooking) return;

    setState(() {
      _isBooking = true;
    });

    try {
      // Get professional ID safely
      final professionalId = widget.selectedProfessional.id ?? '';

      if (professionalId.isEmpty) {
        throw Exception('Professional ID is missing');
      }

      // Create appointment items for each service
      final appointments = widget.selectedServices.map((service) {
        return AppointmentItem(
          salonId: widget.salonId,
          professionalId: professionalId,
          serviceName: service.name,
          price: service.price,
          duration: '${service.duration} minutes',
          date: DateFormat('yyyy-MM-dd').format(widget.selectedDate),
          startTime: widget.selectedTimeSlot.startTime,
        );
      }).toList();

      // Create the appointment
      await BookingService.createAppointment(
        customerName: widget.customerName,
        customerPhone: widget.customerPhoneNumber,
        customerEmail: widget.customerEmail,
        appointments: appointments,
        isGroupBooking: false,
      );

      if (!mounted) return;

      setState(() {
        _isBooking = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 28),
              const SizedBox(width: 12),
              const Text('Booking Confirmed!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your appointment has been successfully booked.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Details:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Customer: ${widget.customerName}'),
                    Text(
                      'Date: ${DateFormat('MMMM dd, yyyy').format(widget.selectedDate)}',
                    ),
                    Text('Time: ${widget.selectedTimeSlot.startTime}'),
                    Text('Professional: ${widget.selectedProfessional.name}'),
                  ],
                ),
              ),
              if (widget.customerEmail.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'A confirmation email has been sent to ${widget.customerEmail}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Pop all booking screens and return to main screen
                Navigator.of(context)
                  ..pop() // Close dialog
                  ..pop() // Close summary
                  ..pop() // Close date/time
                  ..pop() // Close professional
                  ..pop(); // Close service selection
              },
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isBooking = false;
      });

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade600, size: 28),
              const SizedBox(width: 12),
              const Text('Booking Failed'),
            ],
          ),
          content: Text(
            'Failed to create appointment: ${e.toString()}',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
          'Appointment Summary',
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
                  _buildInfoField('Customer name', widget.customerName),
                  const SizedBox(height: 16),
                  _buildInfoField(
                    'Customer Phone Number',
                    widget.customerPhoneNumber,
                  ),
                  if (widget.customerEmail.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildInfoField('Customer Email', widget.customerEmail),
                  ],
                  const SizedBox(height: 24),
                  const Text(
                    'Services Selected',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...widget.selectedServices.map(
                    (service) => _buildServiceItem(service),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Professional',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildProfessionalCard(),
                  const SizedBox(height: 24),
                  const Text(
                    'Appointment Date & Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildDateTimeCard(),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Duration',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              totalDuration,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'LKR ${totalPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                onPressed: _isBooking ? null : _confirmAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  disabledBackgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isBooking
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Confirm Appointment',
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

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildServiceItem(ServiceModel service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.cut, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${service.duration} minutes',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            'LKR ${service.price.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              image:
                  widget.selectedProfessional.photoPath != null &&
                      widget.selectedProfessional.isPhotoUrl
                  ? DecorationImage(
                      image: NetworkImage(
                        widget.selectedProfessional.photoPath!,
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.selectedProfessional.photoPath == null
                ? const Icon(Icons.person)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.selectedProfessional.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.selectedProfessional.services.isNotEmpty
                      ? widget.selectedProfessional.services.first
                      : 'Professional',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: Colors.green.shade600),
        ],
      ),
    );
  }

  Widget _buildDateTimeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 24, color: Colors.blue.shade900),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMMM dd, yyyy').format(widget.selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Time: ${widget.selectedTimeSlot.startTime}',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

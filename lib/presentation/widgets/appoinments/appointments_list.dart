import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../utils/appointment_utils.dart';
import '../../../data/models/appoinment.dart';

class AppointmentsList extends StatelessWidget {
  final DateTime selectedDate;
  final List<Appointment> appointments;

  const AppointmentsList({
    super.key,
    required this.selectedDate,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    final dayAppointments = getAppointmentsForDate(selectedDate, appointments);

    if (dayAppointments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.event_busy, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No appointments for this day',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date column on the left
          Column(
            children: [
              Text(
                getMonthAbbr(selectedDate.month),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                selectedDate.day.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Appointment cards
          Expanded(
            child: Column(
              children: dayAppointments
                  .map<Widget>((apt) => _buildAppointmentCard(apt))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    Color borderColor;
    switch (appointment.status.toLowerCase()) {
      case 'completed':
        borderColor = AppColors.completedDot;
        break;
      case 'upcoming':
      case 'confirmed':
      case 'pending':
        borderColor = AppColors.upcomingDot;
        break;
      case 'blocked':
        borderColor = AppColors.blockedDot;
        break;
      default:
        borderColor = Colors.grey;
    }

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border(left: BorderSide(color: borderColor, width: 4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${appointment.displayTime} - ${appointment.professionalName ?? 'No Professional'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Customer: ${appointment.customerName}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
                if (appointment.services.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    appointment.displayService,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

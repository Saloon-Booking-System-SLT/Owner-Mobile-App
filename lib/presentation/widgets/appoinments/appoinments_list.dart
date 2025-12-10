import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'appoinment_card.dart';


class AppointmentsList extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;
  final DateTime selectedDate;
  final String selectedFilter;
  final String selectedProfessional;
  final AnimationController controller;

  const AppointmentsList({
    super.key,
    required this.appointments,
    required this.selectedDate,
    required this.selectedFilter,
    required this.selectedProfessional,
    required this.controller,
  });

  List<Map<String, dynamic>> get filteredAppointments {
    var filtered = appointments.where((apt) {
      final aptDate = DateTime.parse(apt['date']);
      return aptDate.year == selectedDate.year &&
          aptDate.month == selectedDate.month &&
          aptDate.day == selectedDate.day;
    }).toList();

    if (selectedFilter != 'All') {
      filtered = filtered.where((apt) => apt['status'] == selectedFilter).toList();
    }

    if (selectedProfessional != 'All Professionals') {
      filtered = filtered.where((apt) => apt['professional'] == selectedProfessional).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredAppointments;

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: filtered.asMap().entries.map((entry) {
          final index = entry.key;
          final appointment = entry.value;
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(
                  index * 0.1,
                  0.5 + (index * 0.1),
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: Interval(
                    index * 0.1,
                    0.5 + (index * 0.1),
                    curve: Curves.easeOutCubic,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppointmentCard(appointment: appointment),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.lightBlue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.event_busy_outlined,
                size: 56,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No appointments found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'for ${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
import '../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../data/models/appoinment.dart';

enum AppointmentStatus { completed, upcoming, blocked, none }

List<Appointment> getAppointmentsForDate(
  DateTime date,
  List<Appointment> appointments,
) {
  final dateStr =
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  return appointments.where((apt) => apt.date == dateStr).toList();
}

AppointmentStatus getDateStatus(
  DateTime date,
  List<Appointment> appointments,
) {
  final dateStr =
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  final dayAppointments = appointments
      .where((apt) => apt.date == dateStr)
      .toList();

  if (dayAppointments.isEmpty) return AppointmentStatus.none;

  bool hasCompleted = dayAppointments.any(
    (apt) => apt.status.toLowerCase() == 'completed',
  );
  bool hasUpcoming = dayAppointments.any(
    (apt) => apt.status.toLowerCase() == 'upcoming' || apt.status.toLowerCase() == 'confirmed' || apt.status.toLowerCase() == 'pending',
  );
  bool hasBlocked = dayAppointments.any((apt) => apt.status.toLowerCase() == 'blocked');

  if (hasCompleted) return AppointmentStatus.completed;
  if (hasUpcoming) return AppointmentStatus.upcoming;
  if (hasBlocked) return AppointmentStatus.blocked;

  return AppointmentStatus.none;
}

Color getStatusColor(AppointmentStatus status) {
  switch (status) {
    case AppointmentStatus.completed:
      return AppColors.completedDot;
    case AppointmentStatus.upcoming:
      return AppColors.upcomingDot;
    case AppointmentStatus.blocked:
      return AppColors.blockedDot;
    case AppointmentStatus.none:
      return Colors.transparent;
  }
}

String getMonthName(int month) {
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
    'December',
  ];
  return months[month - 1];
}

String getMonthAbbr(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

DateTime navigateMonth(DateTime selectedDate, int direction) {
  final newMonth = selectedDate.month + direction;
  final newYear = newMonth > 12
      ? selectedDate.year + 1
      : newMonth < 1
      ? selectedDate.year - 1
      : selectedDate.year;
  final actualMonth = newMonth > 12
      ? 1
      : newMonth < 1
      ? 12
      : newMonth;
  final lastDayOfNewMonth = DateTime(newYear, actualMonth + 1, 0).day;
  final newDay = selectedDate.day > lastDayOfNewMonth
      ? lastDayOfNewMonth
      : selectedDate.day;
  return DateTime(newYear, actualMonth, newDay);
}

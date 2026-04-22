import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../utils/appointment_utils.dart';
import '../../../data/models/appoinment.dart';

class AppointmentsCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;
  final AnimationController? calendarController;
  final List<Appointment> appointments;
  final void Function(int) navigateMonth;

  const AppointmentsCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.calendarController,
    required this.appointments,
    required this.navigateMonth,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: calendarController ?? const AlwaysStoppedAnimation(1.0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCalendarHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: _buildCalendarGrid(),
            ),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavButton(
            icon: Icons.chevron_left_rounded,
            onPressed: () => navigateMonth(-1),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${getMonthName(selectedDate.month)} ${selectedDate.year}',
                style: const TextStyle(
                  color: AppColors.darkText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          _buildNavButton(
            icon: Icons.chevron_right_rounded,
            onPressed: () => navigateMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.darkText, size: 22),
        padding: const EdgeInsets.all(4),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );
    final startingWeekday = firstDayOfMonth.weekday % 7;
    final totalDays = lastDayOfMonth.day;

    final daysOfWeek = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: daysOfWeek.map<Widget>((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        ..._buildCalendarRows(startingWeekday, totalDays),
      ],
    );
  }

  List<Widget> _buildCalendarRows(int startingWeekday, int totalDays) {
    List<Widget> rows = [];
    List<Widget> currentWeek = [];

    for (int i = 0; i < startingWeekday; i++) {
      currentWeek.add(const Expanded(child: SizedBox(height: 44)));
    }

    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(selectedDate.year, selectedDate.month, day);
      final isSelected = selectedDate.day == day;
      final isToday =
          DateTime.now().year == date.year &&
          DateTime.now().month == date.month &&
          DateTime.now().day == date.day;
      final status = getDateStatus(date, appointments);

      currentWeek.add(
        Expanded(
          child: GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              margin: const EdgeInsets.all(2),
              height: 44,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.upcomingDot
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : isToday
                              ? AppColors.upcomingDot
                              : AppColors.darkText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (status != AppointmentStatus.none)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ),
      );

      if (currentWeek.length == 7) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(children: List.from(currentWeek)),
          ),
        );
        currentWeek = [];
      }
    }

    while (currentWeek.isNotEmpty && currentWeek.length < 7) {
      currentWeek.add(const Expanded(child: SizedBox(height: 44)));
    }

    if (currentWeek.isNotEmpty) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(children: currentWeek),
        ),
      );
    }

    return rows;
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem('Completed', AppColors.completedDot),
          const SizedBox(width: 24),
          _buildLegendItem('Upcoming', AppColors.upcomingDot),
          const SizedBox(width: 24),
          _buildLegendItem('Blocked', AppColors.blockedDot),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

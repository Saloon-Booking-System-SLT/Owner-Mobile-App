import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AppointmentCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final bool Function(DateTime) hasAppointmentOnDate;
  final AnimationController controller;

  const AppointmentCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.hasAppointmentOnDate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.2),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        )),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Color(0xE3BBDEFF),
            boxShadow: [
              BoxShadow(
                color: AppColors.calendarColor.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: _buildCalendarGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavButton(
            icon: Icons.chevron_left_rounded,
            onPressed: () => _navigateMonth(-1),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(
                      //   color: Colors.white.withOpacity(0.3),
                      //   width: 1,
                      // ),
                    ),
                    child: Text(
                      _getMonthName(selectedDate.month),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(
                    //   color: Colors.white.withOpacity(0.3),
                    //   width: 1,
                    // ),
                  ),
                  child: Text(
                    selectedDate.year.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildNavButton(
            icon: Icons.chevron_right_rounded,
            onPressed: () => _navigateMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black, size: 22),
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }

  void _navigateMonth(int direction) {
    final newMonth = selectedDate.month + direction;
    final newYear = newMonth > 12
        ? selectedDate.year + 1
        : newMonth < 1
        ? selectedDate.year - 1
        : selectedDate.year;
    final actualMonth = newMonth > 12 ? 1 : newMonth < 1 ? 12 : newMonth;
    final lastDayOfNewMonth = DateTime(newYear, actualMonth + 1, 0).day;
    final newDay = selectedDate.day > lastDayOfNewMonth
        ? lastDayOfNewMonth
        : selectedDate.day;
    onDateSelected(DateTime(newYear, actualMonth, newDay));
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final startingWeekday = firstDayOfMonth.weekday % 7;
    final totalDays = lastDayOfMonth.day;

    final daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: daysOfWeek.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.95),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        ..._buildCalendarRows(startingWeekday, totalDays),
      ],
    );
  }

  List<Widget> _buildCalendarRows(int startingWeekday, int totalDays) {
    List<Widget> rows = [];
    List<Widget> currentWeek = [];

    for (int i = 0; i < startingWeekday; i++) {
      currentWeek.add(const Expanded(child: SizedBox(height: 38)));
    }

    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(selectedDate.year, selectedDate.month, day);
      final isSelected = selectedDate.year == date.year &&
          selectedDate.month == date.month &&
          selectedDate.day == date.day;
      final isToday = DateTime.now().year == date.year &&
          DateTime.now().month == date.month &&
          DateTime.now().day == date.day;
      final hasAppointment = hasAppointmentOnDate(date);

      currentWeek.add(
        Expanded(
          child: GestureDetector(
            onTap: () => onDateSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.all(2),
              height: 38,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : isToday
                    ? Colors.white.withOpacity(0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: hasAppointment && !isSelected
                    ? Border.all(color: Colors.white.withOpacity(0.4), width: 1.5)
                    : null,
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      day.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected || isToday
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: isSelected
                            ? AppColors.primaryBlue
                            : isToday
                            ? Colors.black
                            : Colors.black.withOpacity(0.95),
                      ),
                    ),
                  ),
                  if (hasAppointment && !isSelected)
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );

      if (currentWeek.length == 7) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(children: List.from(currentWeek)),
          ),
        );
        currentWeek = [];
      }
    }

    while (currentWeek.isNotEmpty && currentWeek.length < 7) {
      currentWeek.add(const Expanded(child: SizedBox(height: 38)));
    }

    if (currentWeek.isNotEmpty) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(children: currentWeek),
        ),
      );
    }

    return rows;
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
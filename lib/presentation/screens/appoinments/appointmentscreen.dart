import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/colors.dart';
import '../../widgets/home/bottom_nav_bar.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String _selectedFilter = 'All';
  DateTime _focusedDay = DateTime(2025, 4, 7);
  DateTime? _selectedDay = DateTime(2025, 4, 7);

  // Store appointment statuses
  final Map<int, String> _appointmentStatuses = {
    0: 'Completed',
    1: 'Pending',
    2: 'In Progress',
    3: 'Cancel',
    4: 'In Progress',
    5: 'Pending',
  };

  // All appointments data
  final List<Map<String, String>> _allAppointments = [
    {'name': 'Ava Bennett', 'time': '9:05 am - 9:35 am', 'service': 'Haircut'},
    {'name': 'Noah Carter', 'time': '10:30 am - 11:45 am', 'service': 'Manicure'},
    {'name': 'Isabella Hayes', 'time': '2 pm - 3 pm', 'service': 'Facial'},
    {'name': 'Isabella Hayes', 'time': '2 pm - 3 pm', 'service': 'Facial'},
    {'name': 'Lucas Foster', 'time': '3 pm - 4 pm', 'service': 'Massage'},
    {'name': 'Lucas Foster', 'time': '3 pm - 4 pm', 'service': 'Massage'},
  ];

  // Add this new map with your existing filter colors map
  final Map<String, Color> _filterColors = {
    'All': const Color(0xFF0D5EAC),
    'Completed': AppColors.statusBlue,
    'Pending': AppColors.statusYellow,
    'In Progress': AppColors.statusGreen,
  };

// Add a new map for unselected text colors
  final Map<String, Color> _filterUnselectedColors = {
    'All': Colors.grey[700]!,
    'Completed': Colors.blue[300]!,
    'Pending': Colors.orange[300]!,
    'In Progress': Colors.green[300]!,
  };
  List<int> _getFilteredAppointmentIndices() {
    if (_selectedFilter == 'All') {
      return List.generate(_allAppointments.length, (index) => index);
    }

    return _appointmentStatuses.entries
        .where((entry) => entry.value == _selectedFilter)
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildCalendar(),
            const SizedBox(height: 16),
            _buildFilterTabs(),
            const SizedBox(height: 16),
            _buildAppointmentsList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        firstDay: DateTime(2020, 1, 1),
        lastDay: DateTime(2050, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.sunday,

        // Header style
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: const TextStyle(
            color: Color(0xFF0D5EAC),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: Color(0xFF0D5EAC),
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: Color(0xFF0D5EAC),
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          titleTextFormatter: (date, locale) {
            final months = [
              'January', 'February', 'March', 'April', 'May', 'June',
              'July', 'August', 'September', 'October', 'November', 'December'
            ];
            return '${months[date.month - 1]}  ${date.year}';
          },
        ),

        // Calendar style
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: const TextStyle(color: Colors.black87),

          // Default day style
          defaultTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),

          // Selected day style
          selectedDecoration: const BoxDecoration(
            color: Color(0xFF0D5EAC),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),

          // Today's style
          todayDecoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),

          cellMargin: const EdgeInsets.all(4),
          cellPadding: const EdgeInsets.all(0),
        ),

        // Days of week style
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            fontSize: 13,
          ),
          weekendStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            fontSize: 13,
          ),
        ),

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },

        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['All', 'Completed', 'Pending', 'In Progress'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((filter) {
          bool isSelected = filter == _selectedFilter;
          Color filterColor = _filterColors[filter] ?? const Color(0xFF0D5EAC);
          Color unselectedColor = _filterUnselectedColors[filter] ?? Colors.grey[700]!;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? filterColor.withOpacity(0.1) : AppColors.buttonBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? filterColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildAppointmentsList() {
    final filteredIndices = _getFilteredAppointmentIndices();

    if (filteredIndices.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          'No appointments found',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return Column(
      children: filteredIndices.map((index) {
        final appointment = _allAppointments[index];
        return _buildAppointmentCard(
          index,
          appointment['name']!,
          appointment['time']!,
          appointment['service']!,
        );
      }).toList(),
    );
  }

  Widget _buildAppointmentCard(int index, String name, String time, String service) {
    final status = _appointmentStatuses[index] ?? 'Pending';
    final statusColor = _getStatusColor(status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        // borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600], size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(fontSize: 14, color: AppColors.text7),
                ),
                Text(
                  service,
                  style: TextStyle(fontSize:  14, color: AppColors.text7),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: PopupMenuButton<String>(
              offset: const Offset(0, 35),
              onSelected: (String newStatus) {
                setState(() {
                  _appointmentStatuses[index] = newStatus;
                });
              },
              itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem('Completed', AppColors.statusBlue),
                _buildPopupMenuItem('Pending', AppColors.statusYellow),
                _buildPopupMenuItem('In Progress', AppColors.statusGreen),
                _buildPopupMenuItem('Cancel', AppColors.statusRed),
              ],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, size: 18, color: statusColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String text, Color color) {
    return PopupMenuItem<String>(
      value: text,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.statusBlue;
      case 'Pending':
        return AppColors.statusYellow;
      case 'In Progress':
        return AppColors.statusGreen;
      case 'Cancel':
        return AppColors.statusRed;
      default:
        return AppColors.statusNone;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/home/bottom_nav_bar.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String _selectedFilter = 'All';
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  
  // Sample appointments data with dates
  // In a real app, this would come from your database
  final List<Map<String, dynamic>> _allAppointments = [
    {
      'id': 0,
      'name': 'Ava Bennett',
      'time': '9:05 am - 9:35 am',
      'service': 'Haircut',
      'status': 'Completed',
      'date': DateTime(2025, 4, 7),
    },
    {
      'id': 1,
      'name': 'Noah Carter',
      'time': '10:30 am - 11:45 am',
      'service': 'Manicure',
      'status': 'Pending',
      'date': DateTime(2025, 4, 7),
    },
    {
      'id': 2,
      'name': 'Isabella Hayes',
      'time': '2 pm - 3 pm',
      'service': 'Facial',
      'status': 'In Progress',
      'date': DateTime(2025, 4, 8),
    },
    {
      'id': 3,
      'name': 'Emma Wilson',
      'time': '11 am - 12 pm',
      'service': 'Pedicure',
      'status': 'Cancel',
      'date': DateTime(2025, 4, 7),
    },
    {
      'id': 4,
      'name': 'Lucas Foster',
      'time': '3 pm - 4 pm',
      'service': 'Massage',
      'status': 'In Progress',
      'date': DateTime(2025, 4, 9),
    },
    {
      'id': 5,
      'name': 'Sophia Davis',
      'time': '1 pm - 2 pm',
      'service': 'Hair Coloring',
      'status': 'Pending',
      'date': DateTime(2025, 4, 7),
    },
  ];

  // Filter appointments based on selected date and status
  List<Map<String, dynamic>> _getFilteredAppointments() {
    return _allAppointments.where((appointment) {
      // Filter by date
      bool matchesDate = _selectedDay == null ||
          isSameDay(appointment['date'], _selectedDay);
      
      // Filter by status
      bool matchesStatus = _selectedFilter == 'All' ||
          appointment['status'] == _selectedFilter;
      
      return matchesDate && matchesStatus;
    }).toList();
  }

  // Update appointment status (this should update your database)
  void _updateAppointmentStatus(int id, String newStatus) {
    setState(() {
      final index = _allAppointments.indexWhere((apt) => apt['id'] == id);
      if (index != -1) {
        _allAppointments[index]['status'] = newStatus;
      }
    });
    
    // TODO: Update status in your database here
    // Example: await updateAppointmentInDatabase(id, newStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
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
        
        // When a day is selected
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        
        // When month/year changes (using chevron buttons)
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['All', 'Completed', 'Pending', 'In Progress', 'Cancel'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((filter) {
          bool isSelected = filter == _selectedFilter;
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
                color: isSelected ? const Color(0xFFE8F2FF) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0D5EAC)
                      : Colors.grey[300]!,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF0D5EAC) : Colors.grey[700],
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
    final filteredAppointments = _getFilteredAppointments();
    
    if (filteredAppointments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.calendar_today_outlined, 
                   size: 64, 
                   color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No appointments found',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _selectedDay != null 
                    ? 'No appointments on ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}'
                    : 'Try selecting a different date or filter',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    
    return Column(
      children: filteredAppointments.map((appointment) {
        return _buildAppointmentCard(
          appointment['id'],
          appointment['name'],
          appointment['time'],
          appointment['service'],
          appointment['status'],
        );
      }).toList(),
    );
  }

  Widget _buildAppointmentCard(
    int id,
    String name,
    String time,
    String service,
    String status,
  ) {
    final statusColor = _getStatusColor(status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                Text(
                  service,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
                _updateAppointmentStatus(id, newStatus);
              },
              itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem('Completed', const Color(0xFF0D5EAC)),
                _buildPopupMenuItem('Pending', Colors.orange[700]!),
                _buildPopupMenuItem('In Progress', Colors.green[700]!),
                _buildPopupMenuItem('Cancel', Colors.red[700]!),
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
        return const Color(0xFF0D5EAC);
      case 'Pending':
        return Colors.orange[700]!;
      case 'In Progress':
        return Colors.green[700]!;
      case 'Cancel':
        return Colors.red[700]!;
      default:
        return Colors.grey[700]!;
    }
  }
}
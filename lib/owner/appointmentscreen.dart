import 'package:flutter/material.dart';


class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String _selectedMonth = 'April';
  int _selectedYear = 2025;
  String _selectedFilter = 'All';

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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildMonthYearSelector(),
            const SizedBox(height: 16),
            _buildCalendar(),
            const SizedBox(height: 16),
            _buildFilterTabs(),
            const SizedBox(height: 16),
            _buildAppointmentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthYearSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Color(0xFF0D5EAC)),
            onPressed: () {},
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0D5EAC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _selectedMonth,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0D5EAC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _selectedYear.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Color(0xFF0D5EAC)),
            onPressed: () {},
          ),
        ],
      ),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((day) => SizedBox(
                      width: 35,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        _buildWeekRow([' ', ' ', '1', '2', '3', '4', '5']),
        _buildWeekRow(['5', '6', '7', '8', '9', '10', '11']),
        _buildWeekRow(['12', '13', '14', '15', '16', '17', '18']),
        _buildWeekRow(['19', '20', '21', '22', '23', '24', '25']),
        _buildWeekRow(['26', '27', '28', '29', '30', ' ', ' ']),
      ],
    );
  }

  Widget _buildWeekRow(List<String> days) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((day) {
          bool isSelected = day == '7';
          return Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0D5EAC) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
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
    return Column(
      children: [
        _buildAppointmentCard(
          'Ava Bennett',
          '9:05 am - 9:35 am',
          'Haircut',
          'Completed',
          Colors.blue,
        ),
        _buildAppointmentCard(
          'Noah Carter',
          '10:30 am - 11:45 am',
          'Manicure',
          'Pending',
          Colors.red,
        ),
        _buildAppointmentCard(
          'Isabella Hayes',
          '2 pm - 3 pm',
          'Facial',
          'In Progress',
          Colors.green,
        ),
        _buildAppointmentCard(
          'Isabella Hayes',
          '2 pm - 3 pm',
          'Facial',
          'Cancel',
          Colors.red,
        ),
        _buildAppointmentCard(
          'Lucas Foster',
          '3 pm - 4 pm',
          'Massage',
          'In Progress',
          Colors.green,
        ),
        _buildAppointmentCard(
          'Lucas Foster',
          '3 pm - 4 pm',
          'Massage',
          'Pending',
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(
    String name,
    String time,
    String service,
    String status,
    Color statusColor,
  ) {
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
            child: Icon(Icons.person, color: Colors.grey[600]),
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
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.arrow_drop_down, size: 18, color: statusColor),
            ],
          ),
        ],
      ),
    );
  }
}

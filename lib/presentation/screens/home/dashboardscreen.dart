import 'package:flutter/material.dart';
import 'package:salon_slt/presentation/screens/profile/salonprofile.dart';

import '../../../core/theme/colors.dart';
import '../../widgets/home/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Store status for each appointment by index
  final Map<int, String> _appointmentStatuses = {
    0: 'Pending',
    1: 'Completed',
    2: 'Completed',
    3: 'Completed',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        // centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: AppColors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SalonProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard('Total\nAppointments', '120'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard('Today\'s\nAppointments', '10'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard('Upcoming\nAppointments', '25'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard('Pending\nApprovals', '5'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                'All Appointments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            _buildAppointmentItem(
              index: 0,
              date: 'Oct 26, 2025',
              name: 'Evelyn Reed',
              time: '10:00 AM',
              customerId: '12345',
              service: 'Haircut',
            ),
            _buildAppointmentItem(
              index: 1,
              date: 'Oct 26, 2025',
              name: 'Chloe Foster',
              time: '11:30 AM',
              customerId: '67890',
              service: 'Manicure',
            ),
            _buildAppointmentItem(
              index: 2,
              date: 'Oct 27, 2025',
              name: 'Abigail Morgan',
              time: '2:00 PM',
              customerId: '24680',
              service: 'Facial',
            ),
            _buildAppointmentItem(
              index: 3,
              date: 'Oct 27, 2025',
              name: 'Harper Brooks',
              time: '3:30 PM',
              customerId: '13579',
              service: 'Hair Coloring',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem({
    required int index,
    required String date,
    required String name,
    required String time,
    required String customerId,
    required String service,
  }) {
    final status = _appointmentStatuses[index] ?? 'Pending';
    final statusColor = _getStatusColor(status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x80F5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '$date • $name',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Customer ID: $customerId',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.dashboardText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.dashboardText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: PopupMenuButton<String>(
              offset: const Offset(0, 35),
              onSelected: (String newStatus) {
                setState(() {
                  _appointmentStatuses[index] = newStatus;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Status changed to $newStatus'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              itemBuilder:
                  (BuildContext context) => [
                    _buildPopupMenuItem('Pending', AppColors.statusYellow),
                    _buildPopupMenuItem('Completed', AppColors.statusBlue),
                    _buildPopupMenuItem('In Progress', AppColors.statusGreen),
                    _buildPopupMenuItem('Cancel', AppColors.statusRed),
                  ],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
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
      case 'Pending':
        return AppColors.statusYellow;
      case 'Completed':
        return AppColors.statusBlue;
      case 'In Progress':
        return AppColors.statusGreen;
      case 'Cancel':
        return AppColors.statusRed;
      default:
        return AppColors.statusNone;
    }
  }
}

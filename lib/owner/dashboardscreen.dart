import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black87),
            onPressed: () {},
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            _buildAppointmentItem(
              date: 'Oct 26, 2025',
              name: 'Evelyn Reed',
              time: '10:00 AM',
              customerId: '12345',
              service: 'Haircut',
              status: 'Pending',
              isPending: true,
            ),
            _buildAppointmentItem(
              date: 'Oct 26, 2025',
              name: 'Chloe Foster',
              time: '11:30 AM',
              customerId: '67890',
              service: 'Manicure',
              status: 'Completed',
              isPending: false,
            ),
            _buildAppointmentItem(
              date: 'Oct 27, 2025',
              name: 'Abigail Morgan',
              time: '2:00 PM',
              customerId: '24680',
              service: 'Facial',
              status: 'Completed',
              isPending: false,
            ),
            _buildAppointmentItem(
              date: 'Oct 27, 2025',
              name: 'Harper Brooks',
              time: '3:30 PM',
              customerId: '13579',
              service: 'Hair Coloring',
              status: 'Completed',
              isPending: false,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
              fontSize: 13,
              color: Colors.grey[800],
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem({
    required String date,
    required String name,
    required String time,
    required String customerId,
    required String service,
    required String status,
    required bool isPending,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$date • ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      time,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Customer ID: $customerId',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text(service,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: isPending
                        ? Colors.red[700]
                        : const Color(0xFF0D5EAC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                  color:
                      isPending ? Colors.red[700] : const Color(0xFF0D5EAC),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
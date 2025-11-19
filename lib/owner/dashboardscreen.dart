import 'package:flutter/material.dart';

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
                    Flexible(
                      child: Text(
                        '$date • $name',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
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
          const SizedBox(width: 8),
          // Status Dropdown Button with fixed width
          SizedBox(
            width: 110,
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
              itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem('Pending', Colors.red[700]!),
                _buildPopupMenuItem('Completed', const Color(0xFF0D5EAC)),
                _buildPopupMenuItem('In Progress', Colors.green[700]!),
                _buildPopupMenuItem('Cancel', Colors.red[700]!),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 18,
                      color: statusColor,
                    ),
                  ],
                ),
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
        return Colors.red[700]!;
      case 'Completed':
        return const Color(0xFF0D5EAC);
      case 'In Progress':
        return Colors.green[700]!;
      case 'Cancel':
        return Colors.red[700]!;
      default:
        return Colors.grey[700]!;
    }
  }
}
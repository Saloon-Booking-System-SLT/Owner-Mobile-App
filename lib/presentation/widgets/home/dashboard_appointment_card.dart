import 'package:flutter/material.dart';

class DashboardAppointmentCard extends StatelessWidget {
  final String time;
  final String customer;
  final String status;
  final bool isInProgress;

  const DashboardAppointmentCard({
    super.key,
    required this.time,
    required this.customer,
    required this.status,
    this.isInProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Completed':
        statusColor = const Color(0xFF4CAF50);
        statusIcon = Icons.check_circle;
        break;
      case 'In Progress':
        statusColor = const Color(0xFF5C4DB1);
        statusIcon = Icons.timer;
        break;
      default:
        statusColor = const Color(0xFF9E9E9E);
        statusIcon = Icons.schedule;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isInProgress ? const Color(0xFF3D3D3D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isInProgress
                      ? const Color(0xFF5C4DB1)
                      : (status == 'Completed'
                            ? const Color(0xFF5C4DB1)
                            : Colors.transparent),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF5C4DB1), width: 2),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Appointment details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time - $customer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isInProgress
                        ? Colors.white
                        : const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: isInProgress
                        ? const Color(0xFFB0B0B0)
                        : const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          // Status icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(isInProgress ? 0.2 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusIcon,
              color: isInProgress ? Colors.white : statusColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

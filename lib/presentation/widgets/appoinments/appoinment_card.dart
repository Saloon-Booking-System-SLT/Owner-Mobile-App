
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(appointment['status']);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAppointmentInfo(),
                ),
                const SizedBox(width: 8),
                _buildStatusColumn(statusInfo),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Hero(
      tag: 'avatar-${appointment['name']}',
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.calendarColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade900,
              // blurRadius: 10,
              // offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            appointment['avatar'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appointment['name'],
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
            letterSpacing: -0.3,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        _buildInfoRow(
          Icons.access_time_rounded,
          appointment['time'],
          Colors.grey[600]!,
        ),
        const SizedBox(height: 4),
        _buildInfoRow(
          Icons.spa_outlined,
          appointment['service'],
          AppColors.primaryBlue,
          isBold: true,
        ),
        const SizedBox(height: 4),
        _buildInfoRow(
          Icons.person_outline_rounded,
          appointment['professional'],
          Colors.grey[500]!,
        ),
      ],
    );
  }

  Widget _buildStatusColumn(Map<String, dynamic> statusInfo) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: statusInfo['bgColor'],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            statusInfo['icon'],
            color: statusInfo['color'],
            size: 20,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: statusInfo['bgColor'],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            appointment['status'],
            style: TextStyle(
              color: statusInfo['color'],
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color,
      {bool isBold = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    switch (status) {
      case 'Completed':
        return {
          'color': AppColors.statusCompleted,
          'bgColor': AppColors.statusCompletedBg,
          'icon': Icons.check_circle_rounded,
        };
      case 'Confirmed':
        return {
          'color': AppColors.statusConfirmed,
          'bgColor': AppColors.statusConfirmedBg,
          'icon': Icons.event_available_rounded,
        };
      case 'Cancel':
        return {
          'color': AppColors.statusCancelled,
          'bgColor': AppColors.statusCancelledBg,
          'icon': Icons.cancel_rounded,
        };
      default:
        return {
          'color': Colors.grey,
          'bgColor': Colors.grey[100]!,
          'icon': Icons.help_outline_rounded,
        };
    }
  }
}
import 'dart:convert';
import 'api_service.dart';
import 'secure_storage_service.dart';

class NotificationService {
  // Get all notifications for salon owner
  static Future<Map<String, dynamic>> getNotifications(String salonId) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Fetch pending appointments
      final appointmentsResponse = await ApiService.getWithToken(
        '/appointments/salon/$salonId',
        token,
      );

      // Fetch pending feedbacks (if you have a route for this)
      // For now, we'll just use appointments

      if (appointmentsResponse.statusCode == 200) {
        final List<dynamic> appointments = jsonDecode(
          appointmentsResponse.body,
        );

        // Filter pending appointments
        final pendingAppointments = appointments
            .where((apt) => apt['status']?.toLowerCase() == 'pending')
            .toList();

        // Filter today's appointments
        final now = DateTime.now();
        final today =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

        final todayAppointments = appointments
            .where((apt) => apt['date'] == today)
            .toList();

        // Build notifications list
        final List<Map<String, dynamic>> notifications = [];

        // Add pending appointment notifications
        for (var apt in pendingAppointments) {
          notifications.add({
            'id': apt['_id'],
            'type': 'pending_appointment',
            'title': 'New Appointment Request',
            'message':
                '${apt['customerName'] ?? 'Customer'} requested ${apt['services']?[0]?['name'] ?? 'a service'}',
            'date': apt['date'],
            'time': apt['startTime'],
            'timestamp': DateTime.parse(
              apt['createdAt'] ?? DateTime.now().toIso8601String(),
            ),
            'data': apt,
            'isRead': false,
          });
        }

        // Add today's appointment reminders
        for (var apt in todayAppointments) {
          if (apt['status']?.toLowerCase() == 'confirmed') {
            notifications.add({
              'id': 'today_${apt['_id']}',
              'type': 'today_appointment',
              'title': 'Appointment Today',
              'message':
                  '${apt['customerName'] ?? 'Customer'} - ${apt['services']?[0]?['name'] ?? 'Service'} at ${apt['startTime']}',
              'date': apt['date'],
              'time': apt['startTime'],
              'timestamp': DateTime.parse(
                apt['date'],
              ).subtract(const Duration(hours: 2)),
              'data': apt,
              'isRead': false,
            });
          }
        }

        // Sort by timestamp (newest first)
        notifications.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

        return {
          'success': true,
          'notifications': notifications,
          'unreadCount': notifications.where((n) => !n['isRead']).length,
          'pendingCount': pendingAppointments.length,
        };
      } else {
        return {'success': false, 'message': 'Failed to fetch notifications'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error fetching notifications: $e'};
    }
  }

  // Get notification count (for badge)
  static Future<Map<String, dynamic>> getNotificationCount(
    String salonId,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await ApiService.getWithToken(
        '/appointments/salon/$salonId',
        token,
      );

      if (response.statusCode == 200) {
        final List<dynamic> appointments = jsonDecode(response.body);

        final pendingCount = appointments
            .where((apt) => apt['status']?.toLowerCase() == 'pending')
            .length;

        return {'success': true, 'count': pendingCount};
      } else {
        return {'success': false, 'count': 0};
      }
    } catch (e) {
      return {'success': false, 'count': 0};
    }
  }

  // Confirm appointment (handle notification action)
  static Future<Map<String, dynamic>> confirmAppointment(
    String appointmentId,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await ApiService.putWithToken(
        '/appointments/$appointmentId/status',
        {'status': 'confirmed'},
        token,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Appointment confirmed successfully',
        };
      } else {
        return {'success': false, 'message': 'Failed to confirm appointment'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error confirming appointment: $e'};
    }
  }

  // Reject appointment
  static Future<Map<String, dynamic>> rejectAppointment(
    String appointmentId,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await ApiService.putWithToken(
        '/appointments/$appointmentId/status',
        {'status': 'cancelled'},
        token,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Appointment cancelled successfully',
        };
      } else {
        return {'success': false, 'message': 'Failed to cancel appointment'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error cancelling appointment: $e'};
    }
  }

  // Format time helper
  static String formatTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = parts[1];
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '$displayHour:$minute $period';
      }
      return time;
    } catch (e) {
      return time;
    }
  }

  // Format date helper
  static String formatDate(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (dateToCheck == today) {
        return 'Today';
      } else if (dateToCheck == yesterday) {
        return 'Yesterday';
      } else {
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        return '${months[dateTime.month - 1]} ${dateTime.day}';
      }
    } catch (e) {
      return date;
    }
  }

  // Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return formatDate(timestamp.toIso8601String());
    }
  }
}

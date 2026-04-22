import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/notification_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  String? errorMessage;
  String? salonId;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Get salon ID
      final profile = await AuthService.getOwnerProfile();
      salonId = profile['salon']?['_id'] ?? profile['salon']?['id'];

      if (salonId == null) {
        setState(() {
          errorMessage = 'Unable to fetch salon information';
          isLoading = false;
        });
        return;
      }

      // Fetch notifications
      final result = await NotificationService.getNotifications(salonId!);

      if (result['success']) {
        setState(() {
          notifications = List<Map<String, dynamic>>.from(
            result['notifications'],
          );
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = result['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading notifications: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _handleConfirm(String appointmentId, int index) async {
    // Show loading
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Confirming appointment...')));

    final result = await NotificationService.confirmAppointment(appointmentId);

    if (!mounted) return;

    if (result['success']) {
      // Remove notification from list
      setState(() {
        notifications.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment confirmed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Failed to confirm appointment'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleReject(String appointmentId, int index) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Appointment'),
        content: const Text(
          'Are you sure you want to reject this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Show loading
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Rejecting appointment...')));

    final result = await NotificationService.rejectAppointment(appointmentId);

    if (!mounted) return;

    if (result['success']) {
      // Remove notification from list
      setState(() {
        notifications.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment rejected'),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Failed to reject appointment'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'pending_appointment':
        return Colors.orange;
      case 'today_appointment':
        return Colors.blue;
      case 'new_feedback':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'pending_appointment':
        return Icons.event_note;
      case 'today_appointment':
        return Icons.today;
      case 'new_feedback':
        return Icons.feedback;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh, color: Colors.black),
        //     onPressed: _loadNotifications,
        //   ),
        // ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                errorMessage!,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadNotifications,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final type = notification['type'] as String;
          final isPending = type == 'pending_appointment';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getNotificationColor(type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getNotificationIcon(type),
                      color: _getNotificationColor(type),
                      size: 24,
                    ),
                  ),
                  title: Text(
                    notification['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        notification['message'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${NotificationService.formatDate(notification['date'])} at ${NotificationService.formatTime(notification['time'])}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    NotificationService.getRelativeTime(
                      notification['timestamp'],
                    ),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ),

                // Action buttons for pending appointments
                if (isPending)
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _handleReject(
                              notification['data']['_id'],
                              index,
                            ),
                            icon: const Icon(Icons.close, size: 18),
                            label: const Text('Reject'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleConfirm(
                              notification['data']['_id'],
                              index,
                            ),
                            icon: const Icon(Icons.check, size: 18),
                            label: const Text('Confirm'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

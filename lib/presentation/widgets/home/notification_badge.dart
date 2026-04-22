import 'package:flutter/material.dart';
import '../../../data/services/notification_service.dart';
import '../../screens/notifications/notification_page.dart';

class NotificationBadge extends StatefulWidget {
  final String salonId;
  final VoidCallback? onNotificationTap;
  final double iconSize;
  final double badgeSize;
  final Color iconColor;
  final Color backgroundColor;
  final Color badgeColor;
  final bool autoRefresh;
  final Duration refreshInterval;

  const NotificationBadge({
    Key? key,
    required this.salonId,
    this.onNotificationTap,
    this.iconSize = 28,
    this.badgeSize = 20,
    this.iconColor = const Color(0xFF666666),
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.badgeColor = Colors.red,
    this.autoRefresh = false,
    this.refreshInterval = const Duration(seconds: 30),
  }) : super(key: key);

  @override
  State<NotificationBadge> createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  int _notificationCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCount();

    // Auto refresh if enabled
    if (widget.autoRefresh) {
      _startAutoRefresh();
    }
  }

  void _startAutoRefresh() {
    Future.delayed(widget.refreshInterval, () {
      if (mounted) {
        _fetchCount();
        _startAutoRefresh();
      }
    });
  }

  Future<void> _fetchCount() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final result = await NotificationService.getNotificationCount(
        widget.salonId,
      );
      if (mounted) {
        setState(() {
          _notificationCount = result['count'] ?? 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleTap() async {
    if (widget.onNotificationTap != null) {
      widget.onNotificationTap!();
    } else {
      // Navigate to notification page
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationPage()),
      );

      // Refresh count when returning
      _fetchCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: widget.iconSize / 2 + 10,
            backgroundColor: widget.backgroundColor,
            child: Icon(
              Icons.notifications,
              color: widget.iconColor,
              size: widget.iconSize,
            ),
          ),
          if (_notificationCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.badgeColor,
                  borderRadius: BorderRadius.circular(widget.badgeSize / 2),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                constraints: BoxConstraints(
                  minWidth: widget.badgeSize,
                  minHeight: widget.badgeSize,
                ),
                child: Text(
                  _notificationCount > 99
                      ? '99+'
                      : _notificationCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (_isLoading)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.badgeColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Simple notification badge for text/number display
class SimpleNotificationBadge extends StatelessWidget {
  final int count;
  final Color color;
  final double size;
  final TextStyle? textStyle;

  const SimpleNotificationBadge({
    Key? key,
    required this.count,
    this.color = Colors.red,
    this.size = 20,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style:
            textStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

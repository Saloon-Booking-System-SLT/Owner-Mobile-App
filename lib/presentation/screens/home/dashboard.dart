import 'package:flutter/material.dart';
import '../../widgets/home/notification_badge.dart';
import '../manage/add_staff_screen.dart';
import '../manage/add_service_screen.dart';
import '../feedbacks/feedbacks.dart';
import '../notifications/notification_page.dart';
import '../../widgets/home/dashboard_appointment_card.dart';
import '../../widgets/home/dashboard_action_button.dart';
import '../promotions/promotions_page.dart';

import '../../../data/models/appoinment.dart';
import '../../../data/services/appointments_service.dart';
import '../../../data/services/auth_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Appointment> _todayAppointments = [];
  bool _isLoading = true;
  double _todayRevenue = 0;
  int _completedCount = 0;
  String? _salonId;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      setState(() => _isLoading = true);
      final profile = await AuthService.getOwnerProfile();
      final salonId = profile['salon'] != null
          ? profile['salon']['id']
          : profile['_id'];

      if (salonId == null) return;
      _salonId = salonId;

      final appointments = await AppointmentsService.fetchAppointments(salonId);

      // Filter for today
      final now = DateTime.now();
      final todayStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final todayApps = appointments.where((a) => a.date == todayStr).toList();

      // Sort by time
      todayApps.sort((a, b) => a.startTime.compareTo(b.startTime));

      // Calculate revenue and completion
      double revenue = 0;
      int completed = 0;
      for (var app in todayApps) {
        final status = app.status.toLowerCase();
        if (status == 'completed' || status == 'confirmed') {
          for (var service in app.services) {
            revenue += service.price;
          }
        }
        if (status == 'completed') {
          completed++;
        }
      }

      setState(() {
        _todayAppointments = todayApps;
        _completedCount = completed;
        _todayRevenue = revenue;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Dashboard Fetch Error: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _fetchDashboardData,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Header with greeting and profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getGreeting(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Salon Owner',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                          // Profile avatar with notification badge
                          NotificationBadge(
                            salonId: _salonId ?? '',
                            autoRefresh: true, // Auto-refresh every 30 seconds
                            refreshInterval: const Duration(seconds: 30),
                            onNotificationTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationPage(),
                                ),
                              );
                              // Refresh dashboard when returning from notifications
                              _fetchDashboardData();
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Revenue Today & Occupancy Cards Row
                      Row(
                        children: [
                          // Revenue Today Card
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF7B68EE),
                                    Color(0xFF9370DB),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Wave decoration...
                                  Positioned(
                                    right: -16,
                                    top: -18,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.15),
                                            Colors.white.withOpacity(0.05),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Content
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Revenue Today',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xD9FFFFFF),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rs ${_todayRevenue.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Confirmed/Paid',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xCCFFFFFF),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Today's Appointments Card
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8A855),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Diamond shape decoration...
                                  Positioned(
                                    right: -10,
                                    top: -15,
                                    child: Transform.rotate(
                                      angle: 0.5,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Content
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Today's Count",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF1A1A1A),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Column(
                                        children: [
                                          Text(
                                            '${_todayAppointments.length}',
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF1A1A1A),
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '$_completedCount Completed',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF4A4A4A),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Actions Section Title
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Actions Container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F3F0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardActionButton(
                              icon: Icons.content_cut_outlined,
                              label: 'Add\nService',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddServiceScreen(),
                                  ),
                                );
                              },
                            ),
                            DashboardActionButton(
                              icon: Icons.person_add_outlined,
                              label: 'Add\nStaff',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddStaffScreen(
                                      availableServices: [],
                                    ),
                                  ),
                                );
                              },
                            ),
                            DashboardActionButton(
                              icon: Icons.local_offer_outlined,
                              label: 'Add\nPromotions',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PromotionsPage(),
                                  ),
                                );
                              },
                            ),
                            DashboardActionButton(
                              icon: Icons.rate_review_outlined,
                              label: 'Feedbacks',
                              onTap: () {
                                if (_salonId != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FeedbacksPage(salonId: _salonId!),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Unable to load salon information',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Today's Appointments Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Today's Appointments",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          Text(
                            _getTodayDate(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Appointments List
                      Expanded(
                        child: _todayAppointments.isEmpty
                            ? const Center(
                                child: Text('No appointments for today'),
                              )
                            : ListView.builder(
                                itemCount: _todayAppointments.length,
                                itemBuilder: (context, index) {
                                  final appointment = _todayAppointments[index];
                                  return DashboardAppointmentCard(
                                    time: appointment.startTime,
                                    customer: appointment.customerName,
                                    status: appointment.status,
                                    isInProgress:
                                        appointment.status.toLowerCase() ==
                                        'in progress',
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  String _getTodayDate() {
    final now = DateTime.now();
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
    return '${months[now.month - 1]} ${now.day}';
  }
}

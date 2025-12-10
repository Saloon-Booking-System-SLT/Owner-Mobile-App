import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/widgets/home/stat_card.dart';
import '../../widgets/home/bottom_nav_bar.dart';
import '../profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String expandedSection = 'all'; // all, today, upcoming

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        // title: Text(
        //   'Dashboard',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 24,
        //     color: Color(0xFF1A1A1A),
        //     letterSpacing: -0.5,
        //   ),
        // ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8),
            const Text(
              "Dashboard",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                // slightly larger like a logo
                fontWeight: FontWeight.w800,
                // more bold = more brand feel
                letterSpacing: 1.2,
                // spacing gives a logo vibe
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),

            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              icon: const Icon(
                Icons.person,
                color: Color(0xFF1A1A1A),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Stats Cards
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.calendar_today_rounded,
                          label: 'Total Appointments',
                          value: '4',
                          backgroundColor: const Color(0x22FFF3E0),
                          iconColor: const Color(0xFF1976D2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.today_rounded,
                          label: "Today's Appointments",
                          value: '3',
                          backgroundColor: const Color(0x22FFF3E0),
                          iconColor: const Color(0xFFF57C00),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.schedule_rounded,
                          label: 'Upcoming',
                          value: '1',
                          backgroundColor: const Color(0x22FFF3E0),
                          iconColor: const Color(0xFF8E24AA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Completed',
                          value: '3',
                          backgroundColor: const Color(0x22FFF3E0),
                          iconColor: const Color(0xFF43A047),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Appointments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.3,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // All Appointments Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _AppointmentSection(
                title: 'All Appointments',
                count: 4,
                isExpanded: expandedSection == 'all',
                onToggle: () {
                  setState(() {
                    expandedSection = expandedSection == 'all' ? '' : 'all';
                  });
                },
                appointments: [
                  _AppointmentData(
                    service: 'Hair cut',
                    date: 'Sat, 29 Nov 2025',
                    time: '9:00 AM - 9:30 AM',
                    stylist: 'Dinken Hansanmali',
                    status: 'Pending',
                    price: 'LKR 500',
                  ),
                  _AppointmentData(
                    service: 'Hair cut',
                    date: 'Sat, 29 Nov 2025',
                    time: '9:00 AM - 9:30 AM',
                    stylist: 'Default',
                    status: 'Confirmed',
                    price: 'LKR 500',
                  ),
                  _AppointmentData(
                    service: 'Hair cut',
                    date: 'Sat, 29 Nov 2025',
                    time: '10:00 AM - 10:30 AM',
                    stylist: 'Dinken',
                    status: 'Pending',
                    price: 'LKR 500',
                  ),
                  _AppointmentData(
                    service: 'Hair cut',
                    date: 'Mon, 01 Dec 2025',
                    time: '9:00 AM - 9:30 AM',
                    stylist: 'Dinken Hansanmali',
                    status: 'Pending',
                    price: 'LKR 500',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Today's Appointments Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _AppointmentSection(
                title: "Today's Appointments",
                count: 3,
                isExpanded: expandedSection == 'today',
                onToggle: () {
                  setState(() {
                    expandedSection = expandedSection == 'today' ? '' : 'today';
                  });
                },
                appointments: [
                  _AppointmentData(
                    service: 'Hair cut',
                    date: '9:00 AM - 9:30 AM',
                    stylist: 'Dinken Hansanmali',
                    status: '',
                    price: 'LKR 500',
                    isToday: true,
                  ),
                  _AppointmentData(
                    service: 'Hair cut',
                    date: '9:00 AM - 9:30 AM',
                    stylist: 'Default',
                    status: '',
                    price: 'LKR 500',
                    isToday: true,
                  ),
                  _AppointmentData(
                    service: 'Hair cut',
                    date: '10:00 AM - 10:30 AM',
                    stylist: 'Default',
                    status: '',
                    price: 'LKR 500',
                    isToday: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Upcoming Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _AppointmentSection(
                title: 'Upcoming',
                count: 1,
                isExpanded: expandedSection == 'upcoming',
                onToggle: () {
                  setState(() {
                    expandedSection = expandedSection == 'upcoming'
                        ? ''
                        : 'upcoming';
                  });
                },
                appointments: [
                  _AppointmentData(
                    service: 'Hair cut',
                    date: 'Dec 01 Mon 2025',
                    time: '2:00 AM - 2:30 AM',
                    stylist: 'Dinken Hansanmali',
                    status: '',
                    price: 'LKR 500',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

class _AppointmentData {
  final String service;
  final String date;
  final String? time;
  final String stylist;
  final String status;
  final String price;
  final bool isToday;

  _AppointmentData({
    required this.service,
    required this.date,
    this.time,
    required this.stylist,
    required this.status,
    required this.price,
    this.isToday = false,
  });
}

class _AppointmentSection extends StatelessWidget {
  final String title;
  final int count;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<_AppointmentData> appointments;

  const _AppointmentSection({
    required this.title,
    required this.count,
    required this.isExpanded,
    required this.onToggle,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onToggle,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1976D2).withOpacity(0.1),
                            const Color(0xFF1976D2).withOpacity(0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color: Color(0xFF1976D2),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF757575),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFAFBFC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appointments.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return _AppointmentCard(appointment: appointments[index]);
                },
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final _AppointmentData appointment;

  const _AppointmentCard({required this.appointment});

  Color _getStatusColor() {
    switch (appointment.status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFF43A047);
      case 'pending':
        return const Color(0xFFF57C00);
      case 'cancelled':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF757575);
    }
  }

  Color _getStatusBackgroundColor() {
    switch (appointment.status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFFE8F5E9);
      case 'pending':
        return const Color(0xFFFFF3E0);
      case 'cancelled':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle appointment tap
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1976D2).withOpacity(0.1),
                            const Color(0xFF1976D2).withOpacity(0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.content_cut_rounded,
                        color: Color(0xFF1976D2),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.service,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                appointment.isToday
                                    ? Icons.access_time_rounded
                                    : Icons.calendar_today_rounded,
                                size: 13,
                                color: const Color(0xFF9E9E9E),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  appointment.isToday
                                      ? appointment.date
                                      : '${appointment.date}${appointment.time != null ? ' · ${appointment.time}' : ''}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline_rounded,
                                size: 13,
                                color: Color(0xFF9E9E9E),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                appointment.stylist,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        appointment.price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ),
                  ],
                ),
                if (appointment.status.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusBackgroundColor(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _getStatusColor(),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              appointment.status,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

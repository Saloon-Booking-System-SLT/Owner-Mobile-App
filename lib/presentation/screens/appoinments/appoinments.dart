import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/appoinment.dart';
import '../../widgets/appoinments/appoinment_calendar.dart';
import '../../widgets/appoinments/appoinment_filters.dart';
import '../../widgets/appoinments/appoinments_list.dart';
import '../../widgets/home/bottom_nav_bar.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  String selectedFilter = 'All';
  String selectedProfessional = 'All Professionals';
  late AnimationController _calendarController;
  late AnimationController _listController;

  final List<Map<String, dynamic>> appointments = AppointmentData.sampleAppointments;

  List<String> get uniqueProfessionals {
    final professionals = appointments
        .map((apt) => apt['professional'] as String)
        .toSet()
        .toList();
    professionals.sort();
    return ['All Professionals', ...professionals];
  }

  bool _hasAppointmentOnDate(DateTime date) {
    return appointments.any((apt) {
      final aptDate = DateTime.parse(apt['date']);
      return aptDate.year == date.year &&
          aptDate.month == date.month &&
          aptDate.day == date.day;
    });
  }

  @override
  void initState() {
    super.initState();
    _calendarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _calendarController.forward();
    _listController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _listController.reset();
      _listController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.darkText,
          ),
        ),
      ),
      backgroundColor:  Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppointmentCalendar(
                      selectedDate: selectedDate,
                      onDateSelected: _onDateSelected,
                      hasAppointmentOnDate: _hasAppointmentOnDate,
                      controller: _calendarController,
                    ),
                    const SizedBox(height: 26),
                    AppointmentFilters(
                      selectedFilter: selectedFilter,
                      onFilterChanged: (filter) {
                        setState(() => selectedFilter = filter);
                      },
                    ),
                    const SizedBox(height: 12),
                    ProfessionalDropdown(
                      selectedProfessional: selectedProfessional,
                      professionals: uniqueProfessionals,
                      onChanged: (professional) {
                        setState(() => selectedProfessional = professional);
                      },
                    ),
                    const SizedBox(height: 16),
                    AppointmentsList(
                      appointments: appointments,
                      selectedDate: selectedDate,
                      selectedFilter: selectedFilter,
                      selectedProfessional: selectedProfessional,
                      controller: _listController,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

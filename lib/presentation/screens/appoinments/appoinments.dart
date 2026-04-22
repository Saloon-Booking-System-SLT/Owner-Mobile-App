import 'package:flutter/material.dart';
import '../../widgets/appoinments/appointments_calendar.dart';
import '../../widgets/appoinments/appointments_list.dart';
import '../../utils/appointment_utils.dart';
import '../booking/book_an_appoinment.dart';
import '../../../data/models/appoinment.dart';
import '../../../data/services/appointments_service.dart';
import '../../../data/services/auth_service.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  AnimationController? _calendarController;

  List<Appointment> allAppointments = [];
  bool isLoading = true;
  String? errorMessage;
  String? salonId;

  @override
  void initState() {
    super.initState();
    _calendarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _calendarController?.forward();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      if (!mounted) return;
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // 1. Get owner profile to find salonId
      final profile = await AuthService.getOwnerProfile();

      // The backend returns the salon info inside a 'salon' object with an 'id' field
      final fetchedSalonId = profile['salon'] != null
          ? profile['salon']['id']
          : profile['_id'];

      if (fetchedSalonId == null) {
        throw Exception('Salon ID not found in profile');
      }

      // Store salonId for navigation
      salonId = fetchedSalonId;

      // 2. Fetch appointments for this salon
      final fetchedAppointments = await AppointmentsService.fetchAppointments(
        fetchedSalonId,
      );

      if (!mounted) return;
      setState(() {
        allAppointments = fetchedAppointments;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $errorMessage')));
      }
    }
  }

  @override
  void dispose() {
    _calendarController?.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _navigateMonth(int direction) {
    setState(() {
      selectedDate = navigateMonth(selectedDate, direction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Appointments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Check if salonId is available before navigating
                if (salonId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookAnAppointment(salonId: salonId!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please wait, loading salon information...',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F1FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3D2EFF), width: 1),
                ),
                child: const Center(
                  child: Text(
                    'Bookings',
                    style: TextStyle(
                      color: Color(0xFF3D2EFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $errorMessage'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchAppointments,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _fetchAppointments,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    AppointmentsCalendar(
                      selectedDate: selectedDate,
                      onDateSelected: _onDateSelected,
                      calendarController: _calendarController,
                      appointments: allAppointments,
                      navigateMonth: _navigateMonth,
                    ),
                    const SizedBox(height: 16),
                    AppointmentsList(
                      selectedDate: selectedDate,
                      appointments: allAppointments,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }
}

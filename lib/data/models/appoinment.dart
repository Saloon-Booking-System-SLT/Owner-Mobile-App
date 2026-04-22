class Appointment {
  final String id;
  final String? salonId;
  final String? professionalId;
  final String? professionalName;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final List<AppointmentService> services;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final bool isGroupBooking;

  Appointment({
    required this.id,
    this.salonId,
    this.professionalId,
    this.professionalName,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.services,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.isGroupBooking = false,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final servicesList = (json['services'] as List? ?? [])
        .map((s) => AppointmentService.fromJson(s))
        .toList();

    return Appointment(
      id: json['_id'] ?? '',
      salonId: json['salonId'] is Map ? json['salonId']['_id'] : json['salonId'],
      professionalId: json['professionalId'] is Map
          ? json['professionalId']['_id']
          : json['professionalId'],
      professionalName: json['professionalId'] is Map
          ? json['professionalId']['name']
          : null,
      customerName: user['name'] ?? '',
      customerPhone: user['phone'] ?? '',
      customerEmail: user['email'] ?? '',
      services: servicesList,
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      status: json['status'] ?? 'pending',
      isGroupBooking: json['isGroupBooking'] ?? false,
    );
  }

  // Helper to get display service name
  String get displayService =>
      services.isNotEmpty ? services.map((s) => s.name).join(', ') : 'No Service';

  // Helper to get display time range
  String get displayTime => '$startTime - $endTime';
}

class AppointmentService {
  final String name;
  final double price;
  final String duration;

  AppointmentService({
    required this.name,
    required this.price,
    required this.duration,
  });

  factory AppointmentService.fromJson(Map<String, dynamic> json) {
    return AppointmentService(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
    );
  }
}


class Appointment {
  final String name;
  final String time;
  final String service;
  final String status;
  final String professional;
  final String date;
  final String avatar;

  Appointment({
    required this.name,
    required this.time,
    required this.service,
    required this.status,
    required this.professional,
    required this.date,
    required this.avatar,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      name: map['name'] ?? '',
      time: map['time'] ?? '',
      service: map['service'] ?? '',
      status: map['status'] ?? '',
      professional: map['professional'] ?? '',
      date: map['date'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }
}

class AppointmentData {
  static final List<Map<String, dynamic>> sampleAppointments = [
    {
      'name': 'Ava Bennett',
      'time': '9:05 am - 9:35 am',
      'service': 'Haircut',
      'status': 'Completed',
      'professional': 'Mike Anderson',
      'date': '2025-12-01',
      'avatar': 'AB',
    },
    {
      'name': 'Noah Carter',
      'time': '10:30 am - 11:45 am',
      'service': 'Manicure',
      'status': 'Confirmed',
      'professional': 'Sarah Johnson',
      'date': '2025-12-01',
      'avatar': 'NC',
    },
    {
      'name': 'Isabella Hayes',
      'time': '12 pm - 1 pm',
      'service': 'Facial',
      'status': 'Confirmed',
      'professional': 'Mike Anderson',
      'date': '2025-12-02',
      'avatar': 'IH',
    },
    {
      'name': 'Isabella Hayes',
      'time': '2 pm - 3 pm',
      'service': 'Facial',
      'status': 'Cancel',
      'professional': 'Sarah Johnson',
      'date': '2025-12-05',
      'avatar': 'IH',
    },
    {
      'name': 'Lucas Foster',
      'time': '3 pm - 4 pm',
      'service': 'Massage',
      'status': 'Confirmed',
      'professional': 'Mike Anderson',
      'date': '2025-12-03',
      'avatar': 'LF',
    },
    {
      'name': 'Lucas Foster',
      'time': '5 pm - 6 pm',
      'service': 'Massage',
      'status': 'Completed',
      'professional': 'Emma Davis',
      'date': '2025-11-28',
      'avatar': 'LF',
    },
    {
      'name': 'Lucas Foster',
      'time': '3 pm - 4 pm',
      'service': 'Massage',
      'status': 'Confirmed',
      'professional': 'Mike Anderson',
      'date': '2025-12-09',
      'avatar': 'LF',
    },
    {
      'name': 'Lucas Foster',
      'time': '3 pm - 4 pm',
      'service': 'Massage',
      'status': 'Confirmed',
      'professional': 'Mike Anderson',
      'date': '2025-12-10',
      'avatar': 'LF',
    },
    {
      'name': 'Isabella Hayes',
      'time': '2 pm - 3 pm',
      'service': 'Facial',
      'status': 'Cancel',
      'professional': 'Sarah Johnson',
      'date': '2025-12-11',
      'avatar': 'IH',
    },
  ];
}
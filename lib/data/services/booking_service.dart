import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'secure_storage_service.dart';

class TimeSlotModel {
  final String id;
  final String startTime;
  final String endTime;
  final bool isBooked;

  TimeSlotModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      id: json['_id'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      isBooked: json['isBooked'] ?? false,
    );
  }
}

class AppointmentItem {
  final String salonId;
  final String professionalId;
  final String serviceName;
  final double price;
  final String duration;
  final String date;
  final String startTime;
  final String? timeSlotId; // Add this field

  AppointmentItem({
    required this.salonId,
    required this.professionalId,
    required this.serviceName,
    required this.price,
    required this.duration,
    required this.date,
    required this.startTime,
    this.timeSlotId, // Optional but recommended
  });

  Map<String, dynamic> toJson() {
    final json = {
      'salonId': salonId,
      'professionalId': professionalId,
      'serviceName': serviceName,
      'price': price,
      'duration': duration,
      'date': date,
      'startTime': startTime,
    };

    // Include timeSlotId if available
    if (timeSlotId != null && timeSlotId!.isNotEmpty) {
      json['timeSlotId'] = timeSlotId as Object;
    }

    return json;
  }
}

class BookingService {
  /// Fetch available time slots for a professional on a specific date
  static Future<List<TimeSlotModel>> fetchAvailableTimeSlots({
    required String professionalId,
    required String date,
  }) async {
    try {
      // Validate inputs
      if (professionalId.isEmpty) {
        throw Exception('Professional ID is required');
      }
      if (date.isEmpty) {
        throw Exception('Date is required');
      }

      // Get authentication token
      final token = await SecureStorage.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Please log in to continue');
      }

      // Build the query parameters
      final endpoint = '/timeslots?professionalId=$professionalId&date=$date';

      // Make the API request
      final response = await ApiService.getWithToken(endpoint, token);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Filter out booked slots and parse the response
        final slots = data
            .map((json) => TimeSlotModel.fromJson(json))
            .where((slot) => !slot.isBooked)
            .toList();

        return slots;
      } else if (response.statusCode == 400) {
        try {
          final error = jsonDecode(response.body);
          throw Exception(error['error'] ?? 'Invalid request');
        } catch (e) {
          throw Exception('Bad request: ${response.body}');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Session expired. Please log in again');
      } else if (response.statusCode == 404) {
        throw Exception('Time slots endpoint not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error. Please try again later');
      } else {
        throw Exception('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new appointment
  static Future<Map<String, dynamic>> createAppointment({
    required String customerName,
    required String customerPhone,
    required String customerEmail,
    required List<AppointmentItem> appointments,
    required bool isGroupBooking,
  }) async {
    try {
      // Validate inputs
      if (customerName.trim().isEmpty) {
        throw Exception('Customer name is required');
      }
      if (customerPhone.trim().isEmpty) {
        throw Exception('Customer phone is required');
      }
      if (appointments.isEmpty) {
        throw Exception('At least one service must be selected');
      }

      // Validate each appointment item
      for (var apt in appointments) {
        if (apt.salonId.isEmpty) throw Exception('Salon ID is missing');
        if (apt.professionalId.isEmpty)
          throw Exception('Professional ID is missing');
        if (apt.serviceName.isEmpty) throw Exception('Service name is missing');
        if (apt.date.isEmpty) throw Exception('Date is missing');
        if (apt.startTime.isEmpty) throw Exception('Start time is missing');
      }

      // Get authentication token
      final token = await SecureStorage.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Please log in to continue');
      }

      // Prepare request body - using correct field names expected by backend
      final body = {
        'name': customerName.trim(), // Changed from customerName to name
        'phone': customerPhone.trim(),
        'email': customerEmail.trim(),
        'appointments': appointments.map((a) => a.toJson()).toList(),
        'isGroupBooking': isGroupBooking,
      };

      // Make the API request
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/appointments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        try {
          final error = jsonDecode(response.body);
          final errorMsg =
              error['error'] ?? error['message'] ?? 'Invalid appointment data';
          throw Exception(errorMsg);
        } catch (e) {
          if (e is Exception) rethrow;
          throw Exception('Invalid appointment data: ${response.body}');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Session expired. Please log in again');
      } else if (response.statusCode == 404) {
        throw Exception('Appointments endpoint not found');
      } else if (response.statusCode == 500) {
        try {
          final error = jsonDecode(response.body);
          throw Exception(error['error'] ?? 'Server error occurred');
        } catch (e) {
          if (e is Exception) rethrow;
          throw Exception('Server error. Please try again');
        }
      } else {
        throw Exception(
          'Failed to create appointment (${response.statusCode})',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}

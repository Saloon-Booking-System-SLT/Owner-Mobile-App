import 'dart:convert';
import '../models/appoinment.dart';
import 'api_service.dart';
import 'secure_storage_service.dart';

class AppointmentsService {
  static Future<List<Appointment>> fetchAppointments(String salonId) async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.getWithToken('/appointments/salon/$salonId', token);

    if (resp.statusCode == 200) {
      final List<dynamic> body = jsonDecode(resp.body);
      return body.map((json) => Appointment.fromJson(json)).toList();
    } else {
      final body = jsonDecode(resp.body);
      throw Exception(body['message'] ?? 'Failed to fetch appointments');
    }
  }
}

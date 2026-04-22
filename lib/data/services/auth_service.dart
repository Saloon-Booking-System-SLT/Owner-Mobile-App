import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'secure_storage_service.dart';

class AuthService {
  // ---------------- UPDATE OWNER PROFILE ----------------
  static Future<Map<String, dynamic>> updateOwnerProfile({
    required String id,
    required String name,
    required String email,
    required String location,
    required String workingHoursStart,
    required String workingHoursEnd,
    String? salonType,
  }) async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.putWithToken('/salons/$id', {
      'name': name,
      'email': email,
      'location': location,
      'salonType': salonType ?? '',
      'workingHours':
          (workingHoursStart.isNotEmpty && workingHoursEnd.isNotEmpty)
          ? '$workingHoursStart - $workingHoursEnd'
          : '',
    }, token);

    // Try to decode JSON, but if not JSON, throw a better error
    Map<String, dynamic> body;
    try {
      body = jsonDecode(resp.body);
    } catch (e) {
      throw Exception(
        'Invalid response from server: ${resp.body.substring(0, 100)}',
      );
    }

    if (resp.statusCode == 200) {
      return body;
    }

    throw Exception(body['message'] ?? 'Failed to update profile');
  }

  // ---------------- LOGIN ----------------
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final resp = await ApiService.login('/salons/login', {
      'email': email,
      'password': password,
    });

    final body = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      final token = body['token'];
      await SecureStorage.saveToken(token);
      return body;
    }

    throw Exception(body['message'] ?? 'Login failed');
  }

  // ---------------- REGISTER + IMAGE ----------------
  static Future<Map<String, dynamic>> registerWithImage({
    required Map<String, String> fields,
    XFile? imageFile,
  }) async {
    final streamedResp = await ApiService.multipartRequest(
      '/salons/register',
      fields,
      imageFile: imageFile,
    );

    final resp = await http.Response.fromStream(streamedResp);
    final body = jsonDecode(resp.body);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final token = body['token'];
      if (token != null) {
        await SecureStorage.saveToken(token);
      }
      return body;
    }

    throw Exception(body['message'] ?? 'Registration failed');
  }

  // ---------------- GET OWNER PROFILE ----------------
  static Future<Map<String, dynamic>> getOwnerProfile() async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.getWithToken('/salons/owner/profile', token);

    final body = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      return body;
    }

    throw Exception(body['message'] ?? 'Failed to fetch profile');
  }
}

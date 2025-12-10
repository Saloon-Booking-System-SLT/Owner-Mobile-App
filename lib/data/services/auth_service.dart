import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'secure_storage_service.dart';

class AuthService {
  // ---------------- LOGIN ----------------
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final resp = await ApiService.login(
      '/salons/login',
      {'email': email, 'password': password},
    );

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
    File? imageFile,
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

    final resp = await ApiService.getWithToken(
      '/salons/owner/profile',
      token,
    );

    final body = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      return body;
    }

    throw Exception(body['message'] ?? 'Failed to fetch profile');
  }

}

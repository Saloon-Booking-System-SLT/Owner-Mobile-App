import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'secure_storage_service.dart';
import '../models/staff_model.dart';

class StaffService {
  static Future<List<StaffModel>> fetchStaff(String salonId) async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.getWithToken(
      '/professionals/$salonId',
      token,
    );

    if (resp.statusCode == 200) {
      final List<dynamic> body = jsonDecode(resp.body);
      return body.map((json) => StaffModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch professionals');
  }

  static Future<StaffModel> addStaff(
    StaffModel staff,
    String salonId, {
    XFile? imageFile,
    XFile? certificateFile,
  }) async {
    final Map<String, String> fields = {
      'name': staff.name,
      'gender': staff.gender,
      'service': staff.services.join(','),
      'serviceAvailability': staff.availability,
      'salonId': salonId,
      'available': staff.isAvailable.toString(),
      // 'workingHours': staff.workingHours, // Backend doesn't support this yet in model
    };

    final Map<String, XFile> files = {};
    if (imageFile != null) files['image'] = imageFile;
    if (certificateFile != null) files['certificate'] = certificateFile;

    final streamedResp = await ApiService.multipartRequest(
      '/professionals',
      fields,
      multipleFiles: files,
    );

    final resp = await http.Response.fromStream(streamedResp);

    if (resp.statusCode == 201) {
      final body = jsonDecode(resp.body);
      return StaffModel.fromJson(body['data']);
    }

    final body = jsonDecode(resp.body);
    throw Exception(
      body['error'] ?? body['message'] ?? 'Failed to add professional',
    );
  }

  static Future<StaffModel> updateStaff(
    String id,
    StaffModel staff, {
    XFile? imageFile,
    XFile? certificateFile,
  }) async {
    final Map<String, String> fields = {
      'name': staff.name,
      'gender': staff.gender,
      'service': staff.services.join(','),
      'serviceAvailability': staff.availability,
      'available': staff.isAvailable.toString(),
    };

    final Map<String, XFile> files = {};
    if (imageFile != null) files['image'] = imageFile;
    if (certificateFile != null) files['certificate'] = certificateFile;

    final streamedResp = await ApiService.multipartRequest(
      '/professionals/$id',
      fields,
      method: 'PUT',
      multipleFiles: files,
    );

    final resp = await http.Response.fromStream(streamedResp);

    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      return StaffModel.fromJson(body['data']);
    }

    final body = jsonDecode(resp.body);
    throw Exception(
      body['error'] ?? body['message'] ?? 'Failed to update professional',
    );
  }

  static Future<void> deleteStaff(String staffId) async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.deleteWithToken(
      '/professionals/$staffId',
      token,
    );

    if (resp.statusCode != 200) {
      final body = jsonDecode(resp.body);
      throw Exception(
        body['error'] ?? body['message'] ?? 'Failed to delete professional',
      );
    }
  }
}

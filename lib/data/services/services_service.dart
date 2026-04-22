import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'secure_storage_service.dart';
import '../models/service_model.dart';

class ServicesService {
  static Future<List<ServiceModel>> fetchServices(String salonId) async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.getWithToken('/services/$salonId', token); 
    // Note: getWithToken in api_service.dart already adds the token if provided, 
    // but here we might need to get it from SecureStorage if not passed.
    // However, looking at api_service.dart, it expects the token as the second argument.
    
    // Let's check api_service.dart implementation again to be sure.
    // If it's like AppointmentsService, it should work similarly.
    
    if (resp.statusCode == 200) {
      final List<dynamic> body = jsonDecode(resp.body);
      return body.map((json) => ServiceModel.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch services');
  }

  static Future<ServiceModel> addService(ServiceModel service, String salonId, {XFile? imageFile}) async {
    final Map<String, String> fields = {
      'name': service.name,
      'category': service.category,
      'description': service.description,
      'price': service.price.toString(),
      'duration': service.duration.toString(),
      'gender': service.gender,
      'salonId': salonId,
    };

    final streamedResp = await ApiService.multipartRequest(
      '/services',
      fields,
      imageFile: imageFile,
    );

    final resp = await http.Response.fromStream(streamedResp);

    if (resp.statusCode == 201) {
      return ServiceModel.fromJson(jsonDecode(resp.body));
    }
    
    final body = jsonDecode(resp.body);
    throw Exception(body['message'] ?? 'Failed to add service');
  }

  static Future<void> deleteService(String serviceId) async {
    final token = await SecureStorage.getToken();
    if (token == null) throw Exception('No token stored');

    final resp = await ApiService.deleteWithToken('/services/$serviceId', token);

    if (resp.statusCode != 200) {
      final body = jsonDecode(resp.body);
      throw Exception(body['message'] ?? 'Failed to delete service');
    }
  }

  static Future<ServiceModel> updateService(String id, ServiceModel service, {XFile? imageFile}) async {
    final Map<String, String> fields = {
      'name': service.name,
      'category': service.category,
      'description': service.description,
      'price': service.price.toString(),
      'duration': service.duration.toString(),
      'gender': service.gender,
    };

    final streamedResp = await ApiService.multipartRequest(
      '/services/$id',
      fields,
      method: 'PUT',
      imageFile: imageFile,
    );

    final resp = await http.Response.fromStream(streamedResp);

    if (resp.statusCode == 200) {
      return ServiceModel.fromJson(jsonDecode(resp.body));
    }

    final body = jsonDecode(resp.body);
    throw Exception(body['message'] ?? 'Failed to update service');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  // ---------------- PUT with Bearer Token ----------------
  static Future<http.Response> putWithToken(
    String endpoint,
    Map body,
    String token,
  ) async {
    return http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  // Hosted backend base URL
  static const String baseUrl =
      'https://dpdlab1.slt.lk:8447/salon-api/api';

  // ---------------- POST JSON ----------------
  static Future<http.Response> post(
    String endpoint,
    Map body, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final defaultHeaders = {'Content-Type': 'application/json'};
    if (headers != null) defaultHeaders.addAll(headers);

    return http.post(uri, headers: defaultHeaders, body: jsonEncode(body));
  }

  // ---------------- Login wrapper ----------------
  static Future<http.Response> login(String endpoint, Map body) async {
    return post(endpoint, body);
  }

  // ---------------- Multipart Request ----------------
  static Future<http.StreamedResponse> multipartRequest(
    String endpoint,
    Map<String, String> fields, {
    String method = 'POST',
    XFile? imageFile,
    String imageFieldName = 'image',
    Map<String, XFile>? multipleFiles,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest(method, uri);

    request.fields.addAll(fields);

    // Process single image file if provided
    if (imageFile != null) {
      await _addFileToRequest(request, imageFieldName, imageFile);
    }

    // Process multiple files if provided
    if (multipleFiles != null) {
      for (var entry in multipleFiles.entries) {
        await _addFileToRequest(request, entry.key, entry.value);
      }
    }

    if (headers != null) {
      request.headers.addAll(headers);
    }

    return request.send();
  }

  static Future<void> _addFileToRequest(
    http.MultipartRequest request,
    String fieldName,
    XFile file,
  ) async {
    final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
    final type = mimeType.split('/');

    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      final multipart = http.MultipartFile.fromBytes(
        fieldName,
        bytes,
        contentType: MediaType(type[0], type[1]),
        filename: path.basename(file.path),
      );
      request.files.add(multipart);
    } else {
      final multipart = await http.MultipartFile.fromPath(
        fieldName,
        file.path,
        contentType: MediaType(type[0], type[1]),
        filename: path.basename(file.path),
      );
      request.files.add(multipart);
    }
  }

  // ---------------- GET with Bearer Token ----------------
  static Future<http.Response> getWithToken(
    String endpoint,
    String token,
  ) async {
    return http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }
  // ---------------- DELETE with Bearer Token ----------------
  static Future<http.Response> deleteWithToken(
    String endpoint,
    String token,
  ) async {
    return http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }
}

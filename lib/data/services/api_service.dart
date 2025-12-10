import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';

class ApiService {
  // Hosted backend base URL
  static const String baseUrl =
      'https://saloon-booking-system-backend-v2.onrender.com/api';

  // ---------------- POST JSON ----------------
  static Future<http.Response> post(
      String endpoint, Map body,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final defaultHeaders = {'Content-Type': 'application/json'};
    if (headers != null) defaultHeaders.addAll(headers);

    return http.post(
      uri,
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
  }

  // ---------------- Login wrapper ----------------
  static Future<http.Response> login(String endpoint, Map body) async {
    return post(endpoint, body);
  }

  // ---------------- Multipart Request ----------------
  static Future<http.StreamedResponse> multipartRequest(
      String endpoint,
      Map<String, String> fields, {
        File? imageFile,
        String imageFieldName = 'image',
        Map<String, String>? headers,
      }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', uri);

    request.fields.addAll(fields);

    if (imageFile != null) {
      final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
      final type = mimeType.split('/');

      final multipart = await http.MultipartFile.fromPath(
        imageFieldName,
        imageFile.path,
        contentType: MediaType(type[0], type[1]),
        filename: path.basename(imageFile.path),
      );

      request.files.add(multipart);
    }

    if (headers != null) {
      request.headers.addAll(headers);
    }

    return request.send();
  }

  // ---------------- GET with Bearer Token ----------------
  static Future<http.Response> getWithToken(
      String endpoint, String token) async {
    return http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
  }
}

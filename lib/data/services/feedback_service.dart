import 'dart:convert';
import 'api_service.dart';
import 'secure_storage_service.dart';

class FeedbackService {
  // Fetch all feedbacks for a salon (owner side)
  static Future<Map<String, dynamic>> getSalonFeedbacks(String salonId) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await ApiService.getWithToken(
        '/feedback/salon/$salonId',
        token,
      );

      if (response.statusCode == 200) {
        final List<dynamic> feedbacksJson = jsonDecode(response.body);
        return {'success': true, 'feedbacks': feedbacksJson};
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch feedbacks: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error fetching feedbacks: $e'};
    }
  }

  // Fetch all professionals with their feedbacks for a salon
  static Future<Map<String, dynamic>> getProfessionalsWithFeedbacks(
    String salonId,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await ApiService.getWithToken(
        '/feedback/with-feedbacks/$salonId',
        token,
      );

      if (response.statusCode == 200) {
        final List<dynamic> professionalsJson = jsonDecode(response.body);
        return {'success': true, 'professionals': professionalsJson};
      } else {
        return {
          'success': false,
          'message':
              'Failed to fetch professionals with feedbacks: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching professionals with feedbacks: $e',
      };
    }
  }

  // Fetch feedbacks for a specific professional
  static Future<Map<String, dynamic>> getProfessionalFeedbacks(
    String professionalId,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await ApiService.getWithToken(
        '/feedback/professionals/$professionalId',
        token,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'feedbacks': data['feedbacks'],
          'averageRating': data['averageRating'],
        };
      } else {
        return {
          'success': false,
          'message':
              'Failed to fetch professional feedbacks: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching professional feedbacks: $e',
      };
    }
  }

  // Helper method to calculate rating distribution
  static List<Map<String, dynamic>> calculateRatingDistribution(
    List<dynamic> feedbacks,
  ) {
    if (feedbacks.isEmpty) {
      return [
        {'stars': 5, 'percentage': 0, 'count': 0},
        {'stars': 4, 'percentage': 0, 'count': 0},
        {'stars': 3, 'percentage': 0, 'count': 0},
        {'stars': 2, 'percentage': 0, 'count': 0},
        {'stars': 1, 'percentage': 0, 'count': 0},
      ];
    }

    Map<int, int> ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    for (var feedback in feedbacks) {
      int rating = (feedback['rating'] as num).round();
      ratingCounts[rating] = (ratingCounts[rating] ?? 0) + 1;
    }

    int total = feedbacks.length;
    List<Map<String, dynamic>> distribution = [];

    for (int stars = 5; stars >= 1; stars--) {
      int count = ratingCounts[stars] ?? 0;
      double percentage = total > 0 ? (count / total) * 100 : 0;
      distribution.add({
        'stars': stars,
        'percentage': percentage.round(),
        'count': count,
      });
    }

    return distribution;
  }

  // Helper method to calculate average rating
  static double calculateAverageRating(List<dynamic> feedbacks) {
    if (feedbacks.isEmpty) return 0.0;

    double sum = 0;
    for (var feedback in feedbacks) {
      sum += (feedback['rating'] as num).toDouble();
    }

    return sum / feedbacks.length;
  }

  // Format date from ISO string
  static String formatDate(String? isoDate) {
    if (isoDate == null) return 'N/A';
    try {
      DateTime date = DateTime.parse(isoDate);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'N/A';
    }
  }
}

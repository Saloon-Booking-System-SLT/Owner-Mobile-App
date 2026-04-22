import 'package:image_picker/image_picker.dart';

class StaffModel {
  final String? id;
  final String name;
  final String gender;
  final bool isAvailable;
  final List<String> services;
  final String availability;
  final String workingHours;
  final XFile? photo; // Local file for newly added staff
  final String? photoPath; // Can be local path OR URL

  StaffModel({
    this.id,
    required this.name,
    required this.gender,
    required this.isAvailable,
    required this.services,
    required this.availability,
    required this.workingHours,
    this.photo,
    this.photoPath,
  });

  // Factory constructor for JSON deserialization
  factory StaffModel.fromJson(Map<String, dynamic> json) {
    // Backend uses 'service' as string (comma separated)
    List<String> servicesList = [];
    if (json['service'] is String) {
      servicesList = (json['service'] as String)
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else if (json['services'] is List) {
      servicesList = List<String>.from(json['services']);
    }

    return StaffModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      gender: json['gender'] ?? 'Other',
      isAvailable: json['available'] ?? json['isAvailable'] ?? true,
      services: servicesList,
      availability: json['serviceAvailability'] ?? json['availability'] ?? '',
      workingHours:
          json['workingHours'] ??
          '', // Note: Backend Professional model doesn't have workingHours yet
      photoPath: json['image'] != null
          ? (json['image']!.toString().startsWith('http')
                ? json['image']!.toString()
                : 'https://dpdlab1.slt.lk:8447/salon-api/uploads/professionals/${json['image']}')
          : json['photo'] != null
          ? (json['photo']!.toString().startsWith('http')
                ? json['photo']!.toString()
                : 'https://dpdlab1.slt.lk:8447/salon-api/uploads/${json['photo']}')
          : null,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'gender': gender,
      'isAvailable': isAvailable,
      'services': services,
      'availability': availability,
      'workingHours': workingHours,
    };
  }

  // Helper method to check if photoPath is a URL
  bool get isPhotoUrl =>
      photoPath != null &&
      (photoPath!.startsWith('http://') || photoPath!.startsWith('https://'));

  // Helper method to check if has any photo
  bool get hasPhoto => photo != null || photoPath != null;

  // Copy with method for easy updates
  StaffModel copyWith({
    String? id,
    String? name,
    String? gender,
    bool? isAvailable,
    List<String>? services,
    String? availability,
    String? workingHours,
    XFile? photo,
    String? photoPath,
  }) {
    return StaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isAvailable: isAvailable ?? this.isAvailable,
      services: services ?? this.services,
      availability: availability ?? this.availability,
      workingHours: workingHours ?? this.workingHours,
      photo: photo ?? this.photo,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}

import 'dart:io';

class StaffModel {
  final String name;
  final String gender;
  final bool isAvailable;
  final List<String> services;
  final String availability;
  final String workingHours;
  final File? photo; // Local file for newly added staff
  final String? photoPath; // Can be local path OR URL

  StaffModel({
    required this.name,
    required this.gender,
    required this.isAvailable,
    required this.services,
    required this.availability,
    required this.workingHours,
    this.photo,
    this.photoPath,
  });

  // Helper method to check if photoPath is a URL
  bool get isPhotoUrl => photoPath != null &&
      (photoPath!.startsWith('http://') || photoPath!.startsWith('https://'));

  // Helper method to check if has any photo
  bool get hasPhoto => photo != null || photoPath != null;

  // Copy with method for easy updates
  StaffModel copyWith({
    String? name,
    String? gender,
    bool? isAvailable,
    List<String>? services,
    String? availability,
    String? workingHours,
    File? photo,
    String? photoPath,
  }) {
    return StaffModel(
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
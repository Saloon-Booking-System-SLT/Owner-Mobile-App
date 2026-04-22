import 'dart:io';

class RegistrationData {
  String? email;
  String? password;
  String? phone;
  String? salonName;
  String? salonType;
  String? location;
  Map<String, dynamic>? workingHours;
  Map<String, dynamic>? coordinates;
  File? image;

  RegistrationData();

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
      'name': salonName,
      'salonType': salonType,
      'location': location,
      'workingHours': workingHours,
      'coordinates': coordinates,
    };
  }
}
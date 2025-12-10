class ServiceModel {
  final String name;
  final String category;
  final String description;
  final double price;
  final int duration;
  final String gender;
  final String? imageUrl;
  final String? imagePath;

  ServiceModel({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.duration,
    required this.gender,
    this.imageUrl,
    this.imagePath,
  });
}
class ServiceModel {
  final String? id;
  final String name;
  final String category;
  final String description;
  final double price;
  final int duration;
  final String gender;
  final String? imageUrl;
  final String? imagePath;

  ServiceModel({
    this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.duration,
    required this.gender,
    this.imageUrl,
    this.imagePath,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'],
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      duration: int.tryParse(json['duration']?.toString() ?? '0') ?? 0,
      gender: json['gender'] ?? 'Unisex',
      imageUrl: json['image'] != null
          ? (json['image'].startsWith('http')
                ? json['image']
                : 'https://dpdlab1.slt.lk:8447/salon-api/uploads/${json['image']}')
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'duration': duration,
      'gender': gender,
      if (imageUrl != null) 'image': imageUrl,
    };
  }
}

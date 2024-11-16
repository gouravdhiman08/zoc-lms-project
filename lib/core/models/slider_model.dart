// lib/models/slider.dart
class Slider {
  final String id;
  final String url;
  final bool isActive;
  final String createdAt;

  Slider({
    required this.id,
    required this.url,
    required this.isActive,
    required this.createdAt,
  });

  // Factory constructor to create a Slider from JSON data
  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      id: json['_id'] as String,
      url: json['url'] as String,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
    );
  }

  // Method to convert a Slider object to JSON (useful if needed to send data to API)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'url': url,
      'isActive': isActive,
      'createdAt': createdAt,
    };
  }
}

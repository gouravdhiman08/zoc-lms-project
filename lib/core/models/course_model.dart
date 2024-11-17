class CourseModel {
  String id;
  String title;
  String? description; // Nullable description
  int cost;
  Creator createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  List<Video>? videos; // Nullable, videos are optional

  CourseModel({
    required this.id,
    required this.title,
    this.description, // Make description optional
    required this.cost,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    this.videos, // Nullable, optional videos
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    var videosFromJson = json['videos'] as List?; // Nullable list
    List<Video> videosList = videosFromJson != null
        ? videosFromJson.map((i) => Video.fromJson(i)).toList()
        : []; // If videos are null, return an empty list

    return CourseModel(
      id: json['_id'] ?? '', // Ensure non-null value
      title: json['title'] ?? 'Untitled', // Default to 'Untitled' if null
      description: json['description'], // Nullable description
      cost: json['cost'] ?? 0, // Default to 0 if null
      createdBy: Creator.fromJson(json['createdBy'] ?? {}), // Safe check for createdBy
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      imageUrl: json['imageUrl'] ?? '', // Default to empty string if null
      videos: videosList.isEmpty ? null : videosList, // Return null if no videos
    );
  }
}

class Creator {
  String id;
  String name;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  Creator({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'] ?? '', // Handle nulls safely
      name: json['name'] ?? 'Unknown', // Default to 'Unknown' if null
      email: json['email'] ?? '', // Default to empty string if null
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class Video {
  String id;
  String title;
  String url;
  String courseId;
  String description;

  Video({
    required this.id,
    required this.title,
    required this.url,
    required this.courseId,
    required this.description,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['_id'] ?? '', // Ensure ID is non-null
      title: json['title'] ?? 'Untitled', // Default to 'Untitled' if null
      url: json['url'] ?? '', // Default to empty string if null
      courseId: json['courseId'] ?? '', // Default to empty string if null
      description: json['description'] ?? '', // Default to empty string if null
    );
  }
}

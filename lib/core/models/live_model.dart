import 'package:zoc_lms_project/core/models/course_model.dart';

class LiveVideo {
  String id;
  String title;
  String url;
  String courseId;
  CourseModel? courseDetails;
  String description;
  bool isLive;

  LiveVideo({
    required this.id,
    required this.title,
    required this.url,
    required this.courseId,
    this.courseDetails,
    required this.description,
    required this.isLive,
  });

  factory LiveVideo.fromJson(Map<String, dynamic> json) {
    String courseId = '';
    CourseModel? courseDetails;

    try {
      // Handle different courseId formats
      if (json['courseId'] != null) {
        if (json['courseId'] is String) {
          courseId = json['courseId'];
        } else if (json['courseId'] is Map<String, dynamic>) {
          var courseData = json['courseId'] as Map<String, dynamic>;
          courseId = courseData['_id'] ?? '';
          try {
            courseDetails = CourseModel.fromJson(courseData);
          } catch (e) {
            print("Error parsing course details: $e");
          }
        }
      }

      return LiveVideo(
        id: json['_id']?.toString() ?? '',
        title: json['title']?.toString() ?? 'Untitled',
        url: json['url']?.toString() ?? '',
        courseId: courseId,
        courseDetails: courseDetails,
        description: json['description']?.toString() ?? '',
        isLive: json['isLive'] ?? false,
      );
    } catch (e) {
      print("Error in LiveVideo.fromJson: $e");
      // Return a default LiveVideo object in case of parsing errors
      return LiveVideo(
        id: '',
        title: 'Error Loading Video',
        url: '',
        courseId: '',
        courseDetails: null,
        description: '',
        isLive: false,
      );
    }
  }
}
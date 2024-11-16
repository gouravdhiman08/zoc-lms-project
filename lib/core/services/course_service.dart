import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zoc_lms_project/core/models/course_model.dart';
import 'package:zoc_lms_project/core/utils/appUrls.dart';

class CourseService {
  final String baseUrl = AppUrls.coursefetch.toString();

  // Fetch courses from the API
  Future<List<CourseModel>> fetchCourses() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if data exists in the response
        if (jsonResponse['success'] == true) {
          List<dynamic> courseList = jsonResponse['data'] ?? [];
          return courseList
              .map((courseData) => CourseModel.fromJson(courseData))
              .toList();
        } else {
          throw Exception('Failed to load courses. Success flag is false.');
        }
      } else {
        throw Exception(
            'Failed to load courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching courses: $e");
      throw Exception('Error fetching courses: $e');
    }
  }
}

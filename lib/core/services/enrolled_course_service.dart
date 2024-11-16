import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoc_lms_project/core/helpers/request_helpers.dart';
import 'package:zoc_lms_project/core/utils/appConfig.dart';
import 'package:zoc_lms_project/core/utils/appUrls.dart';

class EnrolledCoursesService {
  // Method to fetch enrolled courses for a user
  Future<Map<String, dynamic>> fetchEnrolledCourses() async {
    try {
      // Retrieve the email from SharedPreferences
      final pref = await SharedPreferences.getInstance();
      final email = pref.getString('email'); // Get the stored email
      print(email);

      if (email == null) {
        throw Exception('User email not found in SharedPreferences');
      }

      // Prepare the request body with email
      final requestBody = json.encode({
        'email': email,
      });

      final response = await http.post(
        Uri.parse(
            '${AppConfig.baseUrl}/api/enrolled-courses'), // Use baseUrl and append path
        headers: {
          'Content-Type': 'application/json',
          ...RequestHelpers.header(), // If you have other common headers
        },
        body: requestBody, // Send the email as JSON body
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data == null || data['enrolledCourses'] == null) {
          return {'message': 'No courses found'};
        }
        return data;
      } else {
        throw Exception('Failed to load enrolled courses');
      }
    } catch (e) {
      throw Exception('Error fetching enrolled courses: $e');
    }
  }

  // Fetch individual course by ID
  Future<Map<String, dynamic>> fetchCoursebyid(String courseId) async {
    try {
      final response =
          await http.get(Uri.parse('${AppUrls.learningdetail}/$courseId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (!data['success']) {
          throw Exception(data['message']);
        }

        // Do something with the data, e.g., return the course object
        // CourseModel course = CourseModel.fromJson(data['data']);
        print(data['data']);
        // Handle the data, e.g., store or pass it to the UI
        return data['data'];
      } else {
        throw Exception(
            'Failed to load course details: ${response.statusCode}');
      }
    } catch (err) {
      print('Error fetching course: $err');
      throw Exception('Error fetching course: $err');
    }
  }
}

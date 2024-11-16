import 'package:get/get.dart';
import 'package:zoc_lms_project/core/models/course_model.dart';
import 'package:zoc_lms_project/core/services/enrolled_course_service.dart';

class CourseController extends GetxController {
  final EnrolledCoursesService _enrolledCoursesService =
      EnrolledCoursesService();
  var courses = <CourseModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEnrolledCourses();
  }

  Future<void> fetchEnrolledCourses() async {
    isLoading.value = true;
    errorMessage.value = ''; // Reset previous error message
    try {
      final fetchedData = await _enrolledCoursesService.fetchEnrolledCourses();

      // Parse the enrolledCourses from the API response
      List<CourseModel> fetchedCourses = [];
      if (fetchedData['enrolledCourses'] != null) {
        for (var courseJson in fetchedData['enrolledCourses']) {
          fetchedCourses.add(CourseModel.fromJson(courseJson));
        }
      }

      // Update the courses observable
      courses.value = fetchedCourses;
    } catch (e) {
      errorMessage.value = 'Failed to load enrolled courses: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}

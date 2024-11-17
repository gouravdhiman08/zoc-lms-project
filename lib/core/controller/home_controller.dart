
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/models/course_model.dart';
import 'package:zoc_lms_project/core/models/user_model.dart';
import 'package:zoc_lms_project/core/services/course_service.dart';

class HomeController extends GetxController {
  final UserModel user = UserModel();
  // List<CategoryModel> categories = getCategories;
  RxList<CourseModel> featuredCourses = <CourseModel>[].obs;
  RxInt selectedSliderIndex = RxInt(0);

  // Fetch and populate featured courses
  Future<void> loadFeaturedCourses() async {
    try {
      List<CourseModel> courses = await CourseService().fetchCourses();
      featuredCourses.assignAll(courses); // Reactive list update
    } catch (e) {
      print("Error loading featured courses: $e");
    }
  }

  // Change the slider index
  void changeSliderIndex(int index) {
    selectedSliderIndex.value = index;
  }
}

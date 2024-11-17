import 'package:get/get.dart';
import 'package:zoc_lms_project/core/global/bottombar/bottombar.dart';
import 'package:zoc_lms_project/features/ProfileScreen/ProfileScreen.dart';
import 'package:zoc_lms_project/features/authentication/login/login.dart';
import 'package:zoc_lms_project/features/authentication/signup/signup.dart';
import 'package:zoc_lms_project/features/home/widgets/latestcourse/latest_courses_section.dart';
import 'package:zoc_lms_project/features/splash/splash.dart';

class AppRoutes {
  // Define the route paths
  static const String splash = '/splash';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String courseDetails = '/courseDetails';
  static const String profile = '/profile';

  // Define the GetPage list for GetX routing
  static List<GetPage> getPages = [
    // Splash Screen Route
    GetPage(
      name: splash,
      page: () => const Splash(),
    ),

    // Signup Screen Route
    GetPage(
      name: signup,
      page: () => const Signup(),
    ),

    // Login Screen Route
    GetPage(
      name: login,
      page: () => const Login(),
    ),

    // Home Screen Route
    GetPage(
      name: home,
      page: () => const BottomNavBarExample(),
    ),

    // Course Details Screen Route (You need to create this screen)
    GetPage(
      name: courseDetails,
      page: () => const LatestCoursesSection(),
    ),

    // Profile Screen Route (You need to create this screen)
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
    ),
  ];
}

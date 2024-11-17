import 'package:get/get.dart';
import 'package:zoc_lms_project/core/global/bottombar/bottombar.dart';
import 'package:zoc_lms_project/features/ProfileScreen/ProfileScreen.dart';
import 'package:zoc_lms_project/features/authentication/login/login.dart';
import 'package:zoc_lms_project/features/authentication/signup/signup.dart';
import 'package:zoc_lms_project/features/home/widgets/latestcourse/latest_courses_section.dart';
import 'package:zoc_lms_project/features/splash/splash.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String courseDetails = '/courseDetails';
  static const String profile = '/profile';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const Splash(),
    ),
    GetPage(
      name: login,
      page: () => const Login(),
    ),
    GetPage(
      name: signup,
      page: () => const Signup(),
    ),


    GetPage(
      name: home,
      page: () => const BottomNavBarExample(),
    ),

    GetPage(
      name: courseDetails,
      page: () => const LatestCoursesSection(),
    ),

    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
    ),
  ];
}

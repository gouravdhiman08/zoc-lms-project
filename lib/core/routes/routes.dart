// lib/core/routes/routes.dart

import 'package:get/get.dart';
import 'package:zoc_lms_project/features/home/home.dart';
import 'package:zoc_lms_project/features/authentication/signup/signup.dart';
import 'package:zoc_lms_project/features/splash/splash.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signup = '/signup';
  static const String home = '/home';

  // Define all routes here, using GetPage for GetX navigation
  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => Splash(), // Splash screen route
    ),
    GetPage(
      name: signup,
      page: () => const Signup(), // Reference to Signup Screen
    ),
    GetPage(
      name: home,
      page: () => const Home(), // Reference to Home Screen
    ),
  ];
}


import 'package:zoc_lms_project/core/utils/appConfig.dart';

class AppUrls {
  static const String apiVersion = 'v1';
  static const String apiUrl = AppConfig.baseUrl;
  static Uri login = Uri.parse('$apiUrl/api/auth/login');
  static Uri register = Uri.parse('$apiUrl/api/students/register');
  static Uri coursefetch = Uri.parse('$apiUrl/api/courses');

  static Uri otp = Uri.parse('$apiUrl/api/students/verify-code');
  static Uri resendverifymail =
      Uri.parse('$apiUrl/api/students/resend-verification-mail');
  static Uri learningdetail = Uri.parse('$apiUrl/api/courses');
    static Uri fetchlive = Uri.parse('$apiUrl/api/videos/get-live');
    static Uri sliderimage = Uri.parse('$apiUrl/api/slider-images');
    static Uri logout = Uri.parse('$apiUrl/api/auth/logout');

}
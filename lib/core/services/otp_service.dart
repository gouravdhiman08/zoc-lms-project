import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoc_lms_project/core/global/custom_alert.dart';
import 'package:zoc_lms_project/core/utils/appUrls.dart';
import 'package:zoc_lms_project/core/utils/assets_manager.dart';


class OtpService {
  // Existing OTP Verification method
  static Future<bool> verifyOtp({
    required String otp,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final email = pref.getString('email') ?? '';

    final Map<String, dynamic> requestData = {
      'email': email,
      'code': otp,
    };

    final request = await http.post(
      AppUrls.otp,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (request.statusCode == 200) {
      final response = jsonDecode(request.body);

      if (response['success']) {
        return true;
      } else {
        _showErrorDialog(response['message']);
        return false;
      }
    } else {
      _showErrorDialog(
          'An error occurred while verifying OTP. Please try again.');
      return false;
    }
  }

  // New method for resending the verification email
  static Future<bool> resendVerificationEmail() async {
    final pref = await SharedPreferences.getInstance();
    final email = pref.getString('email') ?? '';

    final requestData = {'email': email};

    final request = await http.post(
      AppUrls.resendverifymail,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (request.statusCode == 200) {
      final response = jsonDecode(request.body);

      if (response['success']) {
        return true;
      } else {
        _showErrorDialog(response['message']);
        return false;
      }
    } else {
      _showErrorDialog(
          'An error occurred while resending the verification email. Please try again.');
      return false;
    }
  }

  // Helper function to show error dialog
  static void _showErrorDialog(String message) {
    Get.dialog(
      CustomAlert(
        title: 'Error!',
        description: message,
        buttonText: 'Try Again',
        image: AnimationManager.error,
        isAnimated: true,
      ),
      barrierDismissible: false,
    );
  }
}

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoc_lms_project/core/helpers/request_helpers.dart';
import 'package:zoc_lms_project/core/models/user_model.dart';
import 'dart:convert';

import 'package:zoc_lms_project/core/utils/appUrls.dart';

class AuthService {
  static const String demoEmail = "demo@example.com";
  static const String demoPassword = "demoPassword";

  static Future<bool> register({
    required UserModel user,
  }) async {
    final pref = await SharedPreferences.getInstance();

    // Prepare the data in JSON format
    final Map<String, dynamic> requestData = {
      'fullName': user.fullName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'password': user.password,
      'gender': user.gender,
    };

    // Send a POST request with the proper headers and JSON body
    final request = await http.post(
      AppUrls.register,
      headers: {
        'Content-Type': 'application/json', // Set header to application/json
        ...RequestHelpers.header(), // If you have other common headers
      },
      body: jsonEncode(requestData),
      // Convert the map to JSON
    );
    print('Response: ${request.body}');

    // Handle the response
    if (request.statusCode == 200) {
      final response = jsonDecode(request.body);

      // Save email to SharedPreferences
      pref.setString(
          'email', response['user']['email']); // Save the email from response
      return true;
    } else {
      // You can add custom error handling here if needed
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    if (email == demoEmail && password == demoPassword) {
      return true;
    }

    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        AppUrls.login,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        if (responseBody['success']) {
          // Save the token and user data in SharedPreferences
          SharedPreferences pref = await SharedPreferences.getInstance();

          // Save the token and user details
          await pref.setString('token', responseBody['token'] ?? '');
          await pref.setString('userId', responseBody['user']['id'] ?? '');
          await pref.setString(
              'fullName', responseBody['user']['fullName'] ?? '');
          await pref.setString('email', responseBody['user']['email'] ?? '');
          await pref.setString(
              'phoneNumber', responseBody['user']['phoneNumber'] ?? '');
          await pref.setString('gender', responseBody['user']['gender'] ?? '');
          await pref.setBool(
              'isSubscribed', responseBody['user']['isSubscribed'] ?? false);
          await pref.setBool(
              'isVerified', responseBody['user']['isVerified'] ?? false);

          return true;
        } else {
          return false;
        }
      } else {
        // If the request failed
        return false;
      }
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }

// FOR LOGOUT

  static Future<void> logout() async {
      final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    final response = await http.post(
      AppUrls.logout,
      headers: {
        'Content-Type': 'application/json', // Set header to application/json
        ...RequestHelpers.header(), // If you have other common headers
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Logged out successfully');
      final pref = await SharedPreferences.getInstance();

      // Clear the token and user data from SharedPreferences
      await pref.remove('token');
      await pref.remove('userId');
      await pref.remove('fullName');
      await pref.remove('email');
      await pref.remove('phoneNumber');
      await pref.remove('gender');
      await pref.remove('isSubscribed');
      await pref.remove('isVerified');

      // Optionally, make a request to the backend to invalidate the session/token
      // await http.post(AppUrls.logout, headers: {
      //   'Authorization': 'Bearer ${pref.getString('token')}',
      // });

      // After logout, navigate to the login screen
      Get.offAllNamed(
          '/login'); // Replace '/login' with the route to your login screen
    } else {
      print('Failed to logout');
    }
  }
}

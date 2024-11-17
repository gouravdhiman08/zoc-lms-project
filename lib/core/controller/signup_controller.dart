import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/global/custom_alert.dart';
import 'package:zoc_lms_project/core/models/user_model.dart';
import 'package:zoc_lms_project/core/routes/routes.dart';
import 'package:zoc_lms_project/core/services/AuthService.dart';
import 'package:zoc_lms_project/core/utils/assets_manager.dart';
import 'package:zoc_lms_project/features/authentication/OtpScreen/otp_screen.dart';


class SignupControllers extends GetxController {
  final globalKey = GlobalKey<FormState>();
  RxString emailError = RxString('');
  RxString confirmPasswordError = RxString('');
  final UserModel user = UserModel();
  final RxBool isLoading = false.obs;

  // Validating email using a regular expression
  void validateEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);

    emailError.value = regex.hasMatch(email) ? '' : 'Invalid email address';
  }

  // Confirm password validation logic
  void validateConfirmPassword(String confirmPassword) {
    confirmPasswordError.value =
        confirmPassword != user.password ? 'Passwords do not match' : '';
  }

  // Register user logic
  void register() async {
    if (!globalKey.currentState!.validate()) return;

    isLoading.value = true;

    final bool isRegistered = await AuthService.register(user: user);

    // Stop loading
    isLoading.value = false;

    if (isRegistered) {
      _showSuccessDialog();
    } else {
      _showErrorDialog();
    }
  }

  // Show success dialog
  void _showSuccessDialog() {
    Get.dialog(
      CustomAlert(
        title: 'Congratulations',
        description: 'You have completed your registration!',
        buttonText: 'Sounds Good!',
        image: AnimationManager.success,
        isAnimated: true,
        onButtonTap: () => Get.offAllNamed(AppRoutes.login),
      ),
      barrierDismissible: false,
    );
    Get.to(OtpScreen());
  }

  // Show error dialog
  void _showErrorDialog() {
    Get.dialog(
      const CustomAlert(
        title: 'Error!',
        description: 'Something went wrong while trying to register!',
        buttonText: 'Try Again',
        image: AnimationManager.error,
        isAnimated: true,
      ),
      barrierDismissible: false,
    );
  }
}


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/services/otp_service.dart';

class OtpController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  var isLoading = false.obs;
  var resendTime = 30.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  // Timer to handle the resend functionality
  void startResendTimer() {
    resendTime.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime.value > 0) {
        resendTime--;
      } else {
        timer.cancel();
      }
    });
  }

  // Trigger resend OTP request
  void resendOtp() async {
    if (resendTime.value == 0) {
      isLoading.value = true;
      bool success = await OtpService.resendVerificationEmail();
      isLoading.value = false;

      if (success) {
        startResendTimer(); // Restart the timer after successful resend
        Get.snackbar(
          'Success',
          'Verification email resent successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to resend the verification email. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

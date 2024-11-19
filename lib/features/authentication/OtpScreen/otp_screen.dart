import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoc_lms_project/core/controller/otp_controller.dart';
import 'package:zoc_lms_project/core/services/otp_service.dart';
import 'package:zoc_lms_project/core/utils/colors.dart';
import 'package:zoc_lms_project/features/authentication/login/login.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController otpController = Get.put(OtpController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Header Section
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade50,
                    ),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'OTP Verification',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter the verification code sent to',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black54,
                      ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<String>(
                  future: SharedPreferences.getInstance()
                      .then((pref) => pref.getString('email') ?? 'Unknown'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        snapshot.data!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 40),
                // OTP Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      height: 60,
                      child: TextField(
                        controller: otpController.otpControllers[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.blue.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),
                // Verify Button (Wrap only this with Obx for isLoading)
                Obx(() {
                  return ElevatedButton(
                    onPressed: otpController.isLoading.value
                        ? null
                        : () async {
                            String otp = otpController.otpControllers
                                .map((controller) => controller.text)
                                .join();
                            if (otp.length == 6) {
                              otpController.isLoading.value = true;
                              bool success =
                                  await OtpService.verifyOtp(otp: otp);
                              otpController.isLoading.value = false;

                              if (success) {
                                Get.snackbar(
                                  'Success',
                                  'OTP verified successfully',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 2),
                                );
                                // Navigate to Login Screen
                                Get.to(Login());
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'Invalid OTP',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please enter a valid 6-digit OTP',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.withOpacity(0.8),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 2),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: otpController.isLoading.value
                        ? const SizedBox(
                            width: 14,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Verify',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  );
                }),
                const SizedBox(height: 30),
                // Resend Section (Wrap only this with Obx for resendTime)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code? ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    Obx(() {
                      if (otpController.resendTime.value > 0) {
                        return Text(
                          'Resend in ${otpController.resendTime.value}s',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          otpController.resendOtp();
                        },
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

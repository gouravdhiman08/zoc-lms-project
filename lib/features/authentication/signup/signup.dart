import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/controller/signup_controller.dart';
import 'package:zoc_lms_project/core/global/custom_button.dart';
import 'package:zoc_lms_project/core/helpers/dropdown_form.dart';
import 'package:zoc_lms_project/core/helpers/form_helpers.dart';
import 'package:zoc_lms_project/core/utils/colors.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupControllers());
    return Scaffold(
      backgroundColor: Colors.grey[100], // Added background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Section
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        'Register Now!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Text(
                        'Fill the details below',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.5), fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Obx(
                    () => Column(
                      children: [
                        // Login Form
                        Form(
                          key: controller.globalKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                topLabelText: 'Full Name',
                                hintText: 'Enter your full name',
                                prefixIcon: Icons.person_rounded,
                                isRequired: true,
                                isLogin: true,
                                onChanged: (p0) =>
                                    controller.user.fullName = p0,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                topLabelText: 'Phone Number',
                                hintText: 'Enter your Number',
                                prefixIcon: Icons.phone_rounded,
                                keyboardType: TextInputType.number,
                                isRequired: true,
                                onChanged: (p0) =>
                                    controller.user.phoneNumber = p0,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                topLabelText: 'Your Email',
                                hintText: 'Enter your email',
                                prefixIcon: Icons.email_rounded,
                                isRequired: true,
                                onChanged: (username) {
                                  controller.user.email = username;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                topLabelText: 'Password',
                                hintText: 'Enter account password',
                                prefixIcon: Icons.password,
                                isRequired: true,
                                isSecured: true,
                                onChanged: (p0) =>
                                    controller.user.password = p0,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                topLabelText: 'Confirm Password',
                                hintText: 'Re-type your password',
                                prefixIcon: Icons.password,
                                isRequired: true,
                                isSecured: true,
                                errorText: controller
                                        .confirmPasswordError.value.isNotEmpty
                                    ? 'Password mismatched'
                                    : null,
                                onChanged: (p0) {
                                  controller.validateConfirmPassword(p0);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomDropdownButtonFormField(
                                topLabelText: 'Gender',
                                hintText: 'Select your gender',
                                items: ['male', 'female', 'other'],
                                initialValue: 'male',
                                onChanged: (gender) {
                                  controller.user.gender = gender;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a gender';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Login Button
                              CustomButton(
                                isLoading: controller.isLoading.value,
                                buttonTitle: 'Sign Up',
                                onTap: () {
                                  // Check the form is valid or not
                                  if (controller.globalKey.currentState!
                                      .validate()) {
                                    if (controller.emailError.value.isEmpty &&
                                        controller.confirmPasswordError.value
                                            .isEmpty) {
                                      controller.register();
                                    }
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // Create Account Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    // style: TextStyle(opacity: 0.5),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onTap: () => Get.toNamed('/login'),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

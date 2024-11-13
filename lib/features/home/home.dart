import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoc_lms_project/core/utils/colors.dart';
import 'package:zoc_lms_project/features/home/widgets/home_app_bar.dart';
import 'package:zoc_lms_project/features/home/widgets/latest_courses_section.dart';
import 'package:zoc_lms_project/features/home/widgets/slider_section.dart';

class Home extends StatelessWidget {
  const Home ({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the system bar color to black and icons to light
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Set status bar color to black
      statusBarIconBrightness:
          Brightness.light, // Light icons on the status bar
    ));

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * .22,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeAppBar(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          SliderSection(),
                          LatestCoursesSection(),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

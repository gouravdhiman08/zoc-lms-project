import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger navigation after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/signup'); // Navigating to home screen after splash
    });

    return Scaffold(
      backgroundColor: Colors.green[200], // Soft green for agriculture theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Your custom logo or icon can go here
            Icon(
              Icons.agriculture, // Agriculture-related icon
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Agriculture with Arjun (AWA)',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nurturing Growth, One Seed at a Time',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

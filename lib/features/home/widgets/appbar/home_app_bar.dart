import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoc_lms_project/features/ProfileScreen/ProfileScreen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String?>(
                  // Assuming AuthHelper.getName() returns a Future<String?> for the full name.
                  future: AuthHelper.getName(),
                  builder: (context, snapshot) {
                    // If the data is available, show the full name, otherwise show 'ZOC' by default.
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Optional loading indicator
                    }
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Text(
                        'Hi ${snapshot.data},',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Text(
                        'Hi ZOC,', // Default if no name is available
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                const Text(
                  "Let's start learning",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the profile screen
                Get.to(ProfileScreen());
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20, // Adjust radius as per your needs
                child: Icon(
                  Icons
                      .person, // Replace with an appropriate icon for the avatar
                  color: Colors.blue, // Change color if needed
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Simulating AuthHelper to get user name
class AuthHelper {
  static Future<String?> getName() async {
    // Simulate a delay like fetching data from a backend or database
    await Future.delayed(const Duration(seconds: 2));

    // Get SharedPreferences instance
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Retrieve the saved user name (if exists), default to empty string if not found
    String? userName = pref.getString('fullName') ??
        'Guest'; // Default to 'Guest' if no name is found

    return userName;
  }
}

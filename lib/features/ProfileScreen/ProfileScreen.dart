// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zoc_lms_project/core/global/bottombar/company_section.dart';
// import 'package:zoc_lms_project/core/utils/colors.dart';


// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Student Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Profile Header Section with Gradient Background
//             Container(
//               padding: const EdgeInsets.only(bottom: 32),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50], // Light off-white color
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   // Profile Picture
//                   Center(
//                     child: Stack(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.black, width: 3),
//                           ),
//                           child: const CircleAvatar(
//                             radius: 60,
//                             backgroundImage:
//                                 AssetImage('assets/images/logo.jpg'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // const SizedBox(height: 20),

//                   // Name and Tagline
//                   FutureBuilder(
//                     future: AuthHelper.getName(),
//                     builder: (context, snapshot) {
//                       return Column(
//                         children: [
//                           Text(
//                             snapshot.data ?? 'Student Name',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: const Text(
//                               'Student',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Profile Menu Items in Card
//             Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     spreadRadius: 0,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildMenuItem(
//                     icon: Icons.person_outline,
//                     title: 'Personal Information',
//                     onTap: () {
//                       Get.to(PersonalInformation());
//                     },
//                   ),
//                   _buildMenuItem(
//                     icon: Icons.school_outlined,
//                     title: 'My Courses',
//                     onTap: () {
//                       Get.to(MyCoursesScreen());
//                     },
//                   ),
//                   _buildMenuItem(
//                     icon: Icons.settings_outlined,
//                     title: 'Settings',
//                     onTap: () {
//                       Get.to(Settings());
//                     },
//                   ),
//                   _buildMenuItem(
//                     icon: Icons.logout,
//                     title: 'Logout',
//                     onTap: () {
//                       //Dont do anything here sara code function me se handle ho rha hai
//                     },
//                     isLogout: true,
//                   ),
//                 ],
//               ),
//             ),

//             // buildCompanySection(),
//             CompanySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     bool isLogout = false,
//   }) {
//     return InkWell(
//       onTap: () async {
//         // If this is the logout item, call the logout function
//         if (isLogout) {
//           await AuthServices
//               .logout(); // Clear the session and navigate to login screen
//           print('User logged out successfully.');
//         } else {
//           // Handle other actions if necessary
//           onTap();
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey.withOpacity(0.1),
//               width: 1,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: isLogout
//                     ? Colors.red.withOpacity(0.1)
//                     : Colors.blue.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 icon,
//                 color: isLogout ? Colors.red : Colors.blue,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   color: isLogout ? Colors.red : Colors.black87,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: Colors.grey.withOpacity(0.5),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zoc_lms_project/core/utils/colors.dart';

// class PersonalInformation extends StatelessWidget {
//   const PersonalInformation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Personal Information',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primary.withOpacity(0.9),
//         elevation: 0,
//       ),
//       body: FutureBuilder(
//         future: _loadPersonalInfo(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final personalInfo = snapshot.data as Map<String, dynamic>;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildMenuItem(
//                     title: 'Full Name',
//                     value: personalInfo['fullName'] ?? 'N/A',
//                   ),
//                   _buildMenuItem(
//                     title: 'Email',
//                     value: personalInfo['email'] ?? 'N/A',
//                   ),
//                   _buildMenuItem(
//                     title: 'Phone Number',
//                     value: personalInfo['phoneNumber'] ?? 'N/A',
//                   ),
//                   _buildMenuItem(
//                     title: 'Gender',
//                     value: personalInfo['gender'] ?? 'N/A',
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('No data found'));
//           }
//         },
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> _loadPersonalInfo() async {
//     final pref = await SharedPreferences.getInstance();
//     return {
//       'fullName': pref.getString('fullName') ?? 'N/A',
//       'email': pref.getString('email') ?? 'N/A',
//       'phoneNumber': pref.getString('phoneNumber') ?? 'N/A',
//       'gender': pref.getString('gender') ?? 'N/A',
//     };
//   }

//   Widget _buildMenuItem({required String title, required String value}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 6,
//             spreadRadius: 0,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         contentPadding: EdgeInsets.zero,
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//             color: Colors.black87,
//           ),
//         ),
//         trailing: Text(
//           value,
//           style: const TextStyle(
//             fontWeight: FontWeight.w400,
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zoc_lms_project/core/utils/colors.dart';

// class Settings extends StatefulWidget {
//   const Settings({super.key});

//   @override
//   _SettingsState createState() => _SettingsState();
// }

// class _SettingsState extends State<Settings> {
//   bool _isNotificationOn = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadNotificationPreference();
//   }

//   _loadNotificationPreference() async {
//     final pref = await SharedPreferences.getInstance();
//     setState(() {
//       _isNotificationOn = pref.getBool('notificationOn') ?? true;
//     });
//   }

//   _saveNotificationPreference(bool value) async {
//     final pref = await SharedPreferences.getInstance();
//     pref.setBool('notificationOn', value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Settings',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         // centerTitle: true,
//         backgroundColor: AppColors.primary.withOpacity(0.9),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildMenuItem(
//               title: 'Notifications',
//               trailing: Switch(
//                 value: _isNotificationOn,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _isNotificationOn = value;
//                   });
//                   _saveNotificationPreference(value);
//                 },
//               ),
//             ),
//             const SizedBox(height: 12),
//             // Add other settings options here, e.g., Account Settings, Theme, etc.
//             _buildMenuItem(
//               title: 'Account Settings',
//               value: 'Manage your account settings.',
//               onTap: () {
//                 // Handle tap on Account Settings
//               },
//             ),
//             const SizedBox(height: 12),
//             _buildMenuItem(
//               title: 'Privacy Settings',
//               value: 'Set your privacy preferences.',
//               onTap: () {
//                 // Handle tap on Privacy Settings
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Menu item for each setting
//   Widget _buildMenuItem({
//     required String title,
//     String? value,
//     Widget? trailing,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               spreadRadius: 0,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: ListTile(
//           contentPadding: EdgeInsets.zero,
//           title: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//               color: Colors.black87,
//             ),
//           ),
//           trailing: trailing ??
//               (value != null
//                   ? Text(
//                       value,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     )
//                   : const Icon(Icons.arrow_forward_ios, size: 18)),
//         ),
//       ),
//     );
//   }
// }

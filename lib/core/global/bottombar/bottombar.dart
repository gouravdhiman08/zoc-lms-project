import 'package:flutter/material.dart';
import 'package:zoc_lms_project/features/home/home.dart';
import 'package:zoc_lms_project/features/home/widgets/home_app_bar.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  // To manage the current index
  int _currentIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    Home(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body changes based on the current tab selected
      body: _pages[_currentIndex],

      // The Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search_sharp),
          //   label: 'Course',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Agriculture wth Arjun',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.getPages,
    );
  }
}

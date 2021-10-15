import 'package:classified_app/screens/users/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = "Classified app";

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false, // Hide the label 'debug' that appears in the right corner 
      title: _title,
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'app_theme.dart';// Import the AppTheme class
import 'login_screen.dart';// Import the LoginScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver Login App',
      theme: AppTheme.lightTheme, // Use the light theme
      // theme: AppTheme.darkTheme, // Use the dark theme if needed
      home: LoginScreen(),
    );
  }
}

// echo "# khatoonbar" >> README.md
// git init
// git add README.md
// git commit -m "first commit"
// git branch -M main
// git remote add origin https://github.com/asgharkarimi/khatoonbar.git
// git push -u origin main
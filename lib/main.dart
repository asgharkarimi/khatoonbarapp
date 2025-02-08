import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khatoonapp/main_screen.dart';

import 'app_theme.dart';
import 'login_screen.dart'; // For localization support

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Login App',
      theme: AppTheme.lightTheme,
      // Use the light theme
      // theme: AppTheme.darkTheme, // Use the dark theme if needed

      // Set the app's locale to Persian (Farsi)
      locale: const Locale('fa', 'IR'),
      // 'fa' is the language code for Persian, 'IR' is the country code for Iran
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // Persian (Farsi) for Iran
      ],

      home: Directionality(
          textDirection: TextDirection.rtl, child: LoginScreen()),
    );
  }
}

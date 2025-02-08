import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'api_service.dart';
import 'main_screen.dart'; // Import the ApiService class

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? errorMessage;
  final ApiService _apiService = ApiService(); // Create an instance of ApiService

  Future<void> checkDriver() async {
    final String phoneNumber = _phoneNumberController.text.trim();
    final String password = _passwordController.text.trim();

    if (phoneNumber.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "لطفاً شماره تلفن و رمز عبور را وارد کنید.";
      });
      return;
    }

    try {
      final driverData = await _apiService.checkDriver(phoneNumber, password);

      if (driverData != null) {
        // Save user data in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phoneNumber', phoneNumber);
        await prefs.setInt('id', driverData['id']);
        await prefs.setString('name', driverData['name']);
        await prefs.setString('family', driverData['family']);

        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("ورود موفقیت‌آمیز بود!"),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to MainScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = "خطا در ارتباط با سرور. لطفاً دوباره تلاش کنید.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ورود به سیستم"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: "شماره تلفن",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "رمز عبور",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: checkDriver,
              child: Text("ورود"),
            ),
          ],
        ),
      ),
    );
  }
}
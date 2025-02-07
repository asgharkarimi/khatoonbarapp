import 'package:flutter/material.dart';
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
        errorMessage = "Please enter both phone number and password.";
      });
      return;
    }

    try {
      final driverData = await _apiService.checkDriver(phoneNumber, password);

      if (driverData != null) {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login successful!"),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to MainScreen and pass driver data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(driverData: driverData),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
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
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
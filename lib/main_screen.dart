import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final Map<String, dynamic> driverData;

  MainScreen({required this.driverData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ${driverData['name']} ${driverData['family']}!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Text(
              "Driver ID: ${driverData['id']}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
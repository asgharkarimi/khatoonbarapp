import 'dart:convert';
import 'package:http/http.dart' as http;
import 'service_model.dart'; // Import the Service model

class ApiService {
  final String baseUrl = "http://192.168.97.166/khatoonbar/api.php";

  Future<Map<String, dynamic>?> checkDriver(String phoneNumber, String password) async {
    final String url = "$baseUrl?table=drivers&action=check&phonenumber=$phoneNumber&password=$password";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data["message"] == "Driver exists") {
          return data["driver"]; // Return driver data
        } else {
          throw Exception("Driver does not exist or credentials are incorrect.");
        }
      } else {
        throw Exception("Failed to load data. Please try again.");
      }
    } catch (e) {
      throw Exception("An error occurred. Please check your connection.");
    }
  }


  Future<List<Service>> fetchServices() async {
    final String url = "$baseUrl?table=services";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data.length);
        print(data.first);
        return data.map((json) => Service.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load services");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
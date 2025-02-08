import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  // Form key for validation and submission
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _driverIdController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _pricePerTonController = TextEditingController();
  final TextEditingController _transportCostPerTonController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _driverFeeController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _cargoPaymentStatusController = TextEditingController();
  final TextEditingController _loadTypeIdController = TextEditingController();

  // Function to submit the form
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Prepare the data to send
      final Map<String, dynamic> data = {
        "driver_id": int.parse(_driverIdController.text),
        "vehicle_type": _vehicleTypeController.text,
        "origin": _originController.text,
        "destination": _destinationController.text,
        "weight": int.parse(_weightController.text),
        "price_per_ton": int.parse(_pricePerTonController.text),
        "transport_cost_per_ton": int.parse(_transportCostPerTonController.text),
        "date": _dateController.text,
        "driver_fee": int.parse(_driverFeeController.text),
        "customer_name": _customerNameController.text,
        "cargo_payment_status": _cargoPaymentStatusController.text,
        "load_type_id": int.parse(_loadTypeIdController.text),
      };

      // Send the data to the API
      final String url = "http://192.168.97.166/khatoonbar/api.php?table=services";
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      // Check the response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("سرویس با موفقیت اضافه شد!"),
            backgroundColor: Colors.green,
          ),
        );
        // Clear the form after successful submission
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("خطا در افزودن سرویس: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Driver ID
              TextFormField(
                controller: _driverIdController,
                decoration: InputDecoration(
                  labelText: "شناسه راننده",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً شناسه راننده را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Vehicle Type
              TextFormField(
                controller: _vehicleTypeController,
                decoration: InputDecoration(
                  labelText: "نوع وسیله نقلیه",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً نوع وسیله نقلیه را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Origin
              TextFormField(
                controller: _originController,
                decoration: InputDecoration(
                  labelText: "مبدا",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً مبدا را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Destination
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: "مقصد",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً مقصد را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Weight
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: "وزن (کیلوگرم)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً وزن را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Price per Ton
              TextFormField(
                controller: _pricePerTonController,
                decoration: InputDecoration(
                  labelText: "هزینه هر تن (تومان)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً هزینه هر تن را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Transport Cost per Ton
              TextFormField(
                controller: _transportCostPerTonController,
                decoration: InputDecoration(
                  labelText: "هزینه حمل هر تن (تومان)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً هزینه حمل هر تن را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Date
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "تاریخ (YYYY-MM-DD)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً تاریخ را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Driver Fee
              TextFormField(
                controller: _driverFeeController,
                decoration: InputDecoration(
                  labelText: "حقوق راننده (تومان)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً حقوق راننده را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Customer Name
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(
                  labelText: "نام مشتری",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً نام مشتری را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Cargo Payment Status
              TextFormField(
                controller: _cargoPaymentStatusController,
                decoration: InputDecoration(
                  labelText: "وضعیت پرداخت بار",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً وضعیت پرداخت بار را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Load Type ID
              TextFormField(
                controller: _loadTypeIdController,
                decoration: InputDecoration(
                  labelText: "شناسه نوع بار",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "لطفاً شناسه نوع بار را وارد کنید";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("ثبت سرویس"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
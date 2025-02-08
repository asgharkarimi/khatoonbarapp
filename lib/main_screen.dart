import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // برای فرمت‌بندی اعداد
import 'api_service.dart'; // Import the ApiService class
import 'service_model.dart'; // Import the Service model
import 'add_service_screen.dart'; // Import the AddServiceScreen
import 'report_screen.dart'; // Import the ReportScreen

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ApiService _apiService = ApiService();
  List<Service> _services = [];
  bool _isLoading = true; // Initially set to true to show loading icon

  // ایجاد یک فرمت‌کننده برای اعداد با جداکننده هزارگان
  final NumberFormat _numberFormat = NumberFormat.decimalPattern();

  // متغیر برای مدیریت صفحه فعلی
  int _selectedIndex = 0;

  // لیست صفحات
  final List<Widget> _pages = [
    ServiceListScreen(), // صفحه لیست سرویس‌ها
    AddServiceScreen(), // صفحه افزودن سرویس جدید
    ReportScreen(), // صفحه گزارش‌گیری
  ];

  // تابع برای تغییر صفحه
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchServices(); // Fetch data when the screen is initialized
  }

  Future<void> _fetchServices() async {
    try {
      final services = await _apiService.fetchServices();
      setState(() {
        _services = services;
        _isLoading = false; // Hide loading icon after data is fetched
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Hide loading icon even if there's an error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to load services: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? "لیست سرویس‌ها"
            : _selectedIndex == 1
            ? "افزودن سرویس جدید"
            : "گزارش‌گیری"),
        centerTitle: true,
        backgroundColor: Colors.blue, // App bar color
        elevation: 10, // Add shadow
      ),
      body: _pages[_selectedIndex], // نمایش صفحه فعلی
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'لیست سرویس‌ها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'افزودن سرویس',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'گزارش‌گیری',
          ),
        ],
        selectedItemColor: Colors.blue, // رنگ آیتم انتخاب‌شده
        unselectedItemColor: Colors.grey, // رنگ آیتم‌های غیرفعال
      ),
    );
  }
}

// صفحه لیست سرویس‌ها
class ServiceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _MainScreenState mainScreenState =
    context.findAncestorStateOfType<_MainScreenState>()!;

    return mainScreenState._isLoading
        ? Center(child: CircularProgressIndicator()) // Show loading icon
        : Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white], // Gradient background
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: mainScreenState._services.length,
        itemBuilder: (context, index) {
          final service = mainScreenState._services[index];
          return Card(
            elevation: 6, // Add shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Name
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue), // Icon
                      SizedBox(width: 8),
                      Text(
                        "مشتری: ${service.customerName}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Vehicle Type
                  Row(
                    children: [
                      Icon(Icons.directions_car, color: Colors.green), // Icon
                      SizedBox(width: 8),
                      Text(
                        "وسیله نقلیه: ${service.vehicleType}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Origin and Destination
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red), // Icon
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "مبدا: ${service.origin}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green), // Icon
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "مقصد: ${service.destination}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Weight and Price
                  Row(
                    children: [
                      Icon(Icons.scale, color: Colors.orange), // Icon
                      SizedBox(width: 8),
                      Text(
                        "وزن: ${mainScreenState._numberFormat.format(service.weight)} کیلوگرم",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green), // Icon
                      SizedBox(width: 8),
                      Text(
                        "هزینه هر تن: ${mainScreenState._numberFormat.format(service.pricePerTon)} تومان",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.money_off, color: Colors.red), // Icon
                      SizedBox(width: 8),
                      Text(
                        "هزینه حمل هر تن: ${mainScreenState._numberFormat.format(service.transportCostPerTon)} تومان",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Date and Driver Fee
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.purple), // Icon
                      SizedBox(width: 8),
                      Text(
                        "تاریخ: ${service.date}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.payment, color: Colors.blue), // Icon
                      SizedBox(width: 8),
                      Text(
                        "حقوق راننده: ${mainScreenState._numberFormat.format(service.driverFee)} تومان",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Payment Status
                  Row(
                    children: [
                      Icon(Icons.payment, color: Colors.green), // Icon
                      SizedBox(width: 8),
                      Text(
                        "وضعیت پرداخت راننده: ${service.driverPaymentStatus}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.payment, color: Colors.red), // Icon
                      SizedBox(width: 8),
                      Text(
                        "وضعیت پرداخت بار: ${service.cargoPaymentStatus}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
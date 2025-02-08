class Service {
  final int id;
  final String? driverName;
  final String vehicleType;
  final String origin;
  final String destination;
  final int weight;
  final int pricePerTon;
  final int transportCostPerTon;
  final String date;
  final int driverFee;
  final String customerName;
  final int totalPrice;
  final String driverPaymentStatus;
  final String cargoPaymentStatus;
  final String? driverCertificate;
  final String? driverNationalCode;
  final int? loadTypeId;
  final int? driverId;
  final String? loadTypeName;
  final String? driverFamily;

  Service({
    required this.id,
    this.driverName,
    required this.vehicleType,
    required this.origin,
    required this.destination,
    required this.weight,
    required this.pricePerTon,
    required this.transportCostPerTon,
    required this.date,
    required this.driverFee,
    required this.customerName,
    required this.totalPrice,
    required this.driverPaymentStatus,
    required this.cargoPaymentStatus,
    this.driverCertificate,
    this.driverNationalCode,
    this.loadTypeId,
    this.driverId,
    this.loadTypeName,
    this.driverFamily,
  });

  // Factory constructor to create a Service object from JSON
  factory Service.fromJson(Map<String, dynamic> json) {
    print("Parsed Service: $json"); // Debug: Print parsed JSON
    return Service(
      id: json['id'],
      driverName: json['driver_name'],
      vehicleType: json['vehicle_type'],
      origin: json['origin'],
      destination: json['destination'],
      weight: json['weight'],
      pricePerTon: json['price_per_ton'],
      transportCostPerTon: json['transport_cost_per_ton'],
      date: json['date'],
      driverFee: json['driver_fee'],
      customerName: json['customer_name'],
      totalPrice: json['total_price'],
      driverPaymentStatus: json['driver_payment_status'],
      cargoPaymentStatus: json['cargo_payment_status'],
      driverCertificate: json['driver_certificate'],
      driverNationalCode: json['driver_national_code'],
      loadTypeId: json['load_type_id'],
      driverId: json['driver_id'],
      loadTypeName: json['load_type_name'],
      driverFamily: json['driver_family'],
    );
  }
}
class PaymentModel {
  final String id;
  final String rideId;
  final String riderId;
  final String driverId;
  final double amount;
  final String currency;
  final String method;
  final String status;
  final String? transactionId;
  final DateTime? paymentTime;
  final String? stripePaymentIntentId;
  final DriverPayout? driverPayout;
  final double? platformFee;
  final Receipt? receipt;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentModel({
    required this.id,
    required this.rideId,
    required this.riderId,
    required this.driverId,
    required this.amount,
    required this.currency,
    required this.method,
    required this.status,
    this.transactionId,
    this.paymentTime,
    this.stripePaymentIntentId,
    this.driverPayout,
    this.platformFee,
    this.receipt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create PaymentModel from JSON
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['_id'],
      rideId: json['ride'],
      riderId: json['rider'],
      driverId: json['driver'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      method: json['method'],
      status: json['status'],
      transactionId: json['transactionId'],
      paymentTime: json['paymentTime'] != null ? DateTime.parse(json['paymentTime']) : null,
      stripePaymentIntentId: json['stripePaymentIntentId'],
      driverPayout: json['driverPayout'] != null ? DriverPayout.fromJson(json['driverPayout']) : null,
      platformFee: json['platformFee']?.toDouble(),
      receipt: json['receipt'] != null ? Receipt.fromJson(json['receipt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Convert PaymentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ride': rideId,
      'rider': riderId,
      'driver': driverId,
      'amount': amount,
      'currency': currency,
      'method': method,
      'status': status,
      'transactionId': transactionId,
      'paymentTime': paymentTime?.toIso8601String(),
      'stripePaymentIntentId': stripePaymentIntentId,
      'driverPayout': driverPayout?.toJson(),
      'platformFee': platformFee,
      'receipt': receipt?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper to check if payment is completed
  bool get isCompleted => status == 'completed';

  // Helper to check if payment is pending
  bool get isPending => status == 'pending';

  // Helper to check if payment is failed
  bool get isFailed => status == 'failed';

  // Helper to check if payment is refunded
  bool get isRefunded => status == 'refunded';

  // Helper to format amount
  String get formattedAmount {
    return '$currency ${amount.toStringAsFixed(2)}';
  }
}

class DriverPayout {
  final double amount;
  final String status;
  final DateTime? processedAt;

  DriverPayout({
    required this.amount,
    required this.status,
    this.processedAt,
  });

  factory DriverPayout.fromJson(Map<String, dynamic> json) {
    return DriverPayout(
      amount: json['amount'].toDouble(),
      status: json['status'],
      processedAt: json['processedAt'] != null ? DateTime.parse(json['processedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'status': status,
      'processedAt': processedAt?.toIso8601String(),
    };
  }
}

class Receipt {
  final String url;
  final DateTime? generatedAt;

  Receipt({
    required this.url,
    this.generatedAt,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      url: json['url'],
      generatedAt: json['generatedAt'] != null ? DateTime.parse(json['generatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'generatedAt': generatedAt?.toIso8601String(),
    };
  }
}

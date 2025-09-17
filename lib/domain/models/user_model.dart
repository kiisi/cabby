class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final String? homeAddress;
  final String? workAddress;
  final List<FavoriteLocation> favoriteLocations;
  final List<PaymentMethod> paymentMethods;
  final double avgRating;
  final bool active;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePicture,
    this.homeAddress,
    this.workAddress,
    this.favoriteLocations = const [],
    this.paymentMethods = const [],
    this.avgRating = 0.0,
    this.active = true,
    required this.createdAt,
  });

  // Full name getter
  String get fullName => '$firstName $lastName';

  // Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      homeAddress: json['homeAddress'],
      workAddress: json['workAddress'],
      favoriteLocations: (json['favoriteLocations'] as List<dynamic>?)
              ?.map((location) => FavoriteLocation.fromJson(location))
              .toList() ??
          [],
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
              ?.map((method) => PaymentMethod.fromJson(method))
              .toList() ??
          [],
      avgRating: json['avgRating']?.toDouble() ?? 0.0,
      active: json['active'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'homeAddress': homeAddress,
      'workAddress': workAddress,
      'favoriteLocations': favoriteLocations.map((location) => location.toJson()).toList(),
      'paymentMethods': paymentMethods.map((method) => method.toJson()).toList(),
      'avgRating': avgRating,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Copy method for updating user
  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    String? homeAddress,
    String? workAddress,
    List<FavoriteLocation>? favoriteLocations,
    List<PaymentMethod>? paymentMethods,
    double? avgRating,
    bool? active,
  }) {
    return UserModel(
      id: this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      homeAddress: homeAddress ?? this.homeAddress,
      workAddress: workAddress ?? this.workAddress,
      favoriteLocations: favoriteLocations ?? this.favoriteLocations,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      avgRating: avgRating ?? this.avgRating,
      active: active ?? this.active,
      createdAt: this.createdAt,
    );
  }
}

class FavoriteLocation {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  FavoriteLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory FavoriteLocation.fromJson(Map<String, dynamic> json) {
    return FavoriteLocation(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PaymentMethod {
  final String id;
  final String type;
  final bool isDefault;
  final CardDetails? cardDetails;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.isDefault,
    this.cardDetails,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['_id'],
      type: json['type'],
      isDefault: json['default'] ?? false,
      cardDetails: json['cardDetails'] != null ? CardDetails.fromJson(json['cardDetails']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'default': isDefault,
      'cardDetails': cardDetails?.toJson(),
    };
  }
}

class CardDetails {
  final String last4;
  final String brand;
  final int expiryMonth;
  final int expiryYear;

  CardDetails({
    required this.last4,
    required this.brand,
    required this.expiryMonth,
    required this.expiryYear,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      last4: json['last4'],
      brand: json['brand'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last4': last4,
      'brand': brand,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
    };
  }
}

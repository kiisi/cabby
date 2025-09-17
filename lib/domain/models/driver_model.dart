class DriverModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? email;
  final String? profilePicture;
  final VehicleDetails vehicleDetails;
  final GeoLocation? currentLocation;
  final bool isAvailable;
  final double avgRating;
  final int totalRides;

  DriverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.email,
    this.profilePicture,
    required this.vehicleDetails,
    this.currentLocation,
    this.isAvailable = false,
    this.avgRating = 0.0,
    this.totalRides = 0,
  });

  // Full name getter
  String get fullName => '$firstName $lastName';

  // Factory constructor to create DriverModel from JSON
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      vehicleDetails: VehicleDetails.fromJson(json['vehicleDetails']),
      currentLocation: json['currentLocation'] != null ? GeoLocation.fromJson(json['currentLocation']) : null,
      isAvailable: json['isAvailable'] ?? false,
      avgRating: json['avgRating']?.toDouble() ?? 0.0,
      totalRides: json['totalRides'] ?? 0,
    );
  }

  // Convert DriverModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'profilePicture': profilePicture,
      'vehicleDetails': vehicleDetails.toJson(),
      'currentLocation': currentLocation?.toJson(),
      'isAvailable': isAvailable,
      'avgRating': avgRating,
      'totalRides': totalRides,
    };
  }
}

class VehicleDetails {
  final String make;
  final String model;
  final int year;
  final String color;
  final String licensePlate;
  final String vehicleType;

  VehicleDetails({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
    required this.vehicleType,
  });

  // Factory constructor to create VehicleDetails from JSON
  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
      make: json['make'],
      model: json['model'],
      year: json['year'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      vehicleType: json['vehicleType'],
    );
  }

  // Convert VehicleDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'licensePlate': licensePlate,
      'vehicleType': vehicleType,
    };
  }

  // Get vehicle description
  String get description => '$year $color $make $model';
}

class GeoLocation {
  final String type;
  final List<double> coordinates;

  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  double get longitude => coordinates[0];
  double get latitude => coordinates[1];

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

import 'driver_model.dart';

class RideModel {
  final String id;
  final String riderId;
  final DriverModel? driver;
  final LocationPoint pickup;
  final LocationPoint destination;
  final String status;
  final String? cancellationReason;
  final String? cancelledBy;
  final double distance;
  final int duration;
  final Fare fare;
  final String paymentMethod;
  final String paymentStatus;
  final double? driverRating;
  final double? riderRating;
  final String? driverFeedback;
  final String? riderFeedback;
  final DateTime requestTime;
  final DateTime? acceptTime;
  final DateTime? pickupTime;
  final DateTime? startTime;
  final DateTime? endTime;

  RideModel({
    required this.id,
    required this.riderId,
    this.driver,
    required this.pickup,
    required this.destination,
    required this.status,
    this.cancellationReason,
    this.cancelledBy,
    required this.distance,
    required this.duration,
    required this.fare,
    required this.paymentMethod,
    required this.paymentStatus,
    this.driverRating,
    this.riderRating,
    this.driverFeedback,
    this.riderFeedback,
    required this.requestTime,
    this.acceptTime,
    this.pickupTime,
    this.startTime,
    this.endTime,
  });

  // Factory constructor to create RideModel from JSON
  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'],
      riderId: json['rider'],
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      pickup: LocationPoint.fromJson(json['pickup']),
      destination: LocationPoint.fromJson(json['destination']),
      status: json['status'],
      cancellationReason: json['cancellationReason'],
      cancelledBy: json['cancelledBy'],
      distance: json['distance'].toDouble(),
      duration: json['duration'],
      fare: Fare.fromJson(json['fare']),
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      driverRating: json['driverRating']?.toDouble(),
      riderRating: json['riderRating']?.toDouble(),
      driverFeedback: json['driverFeedback'],
      riderFeedback: json['riderFeedback'],
      requestTime: DateTime.parse(json['requestTime']),
      acceptTime: json['acceptTime'] != null ? DateTime.parse(json['acceptTime']) : null,
      pickupTime: json['pickupTime'] != null ? DateTime.parse(json['pickupTime']) : null,
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }

  // Convert RideModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'rider': riderId,
      'driver': driver?.toJson(),
      'pickup': pickup.toJson(),
      'destination': destination.toJson(),
      'status': status,
      'cancellationReason': cancellationReason,
      'cancelledBy': cancelledBy,
      'distance': distance,
      'duration': duration,
      'fare': fare.toJson(),
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'driverRating': driverRating,
      'riderRating': riderRating,
      'driverFeedback': driverFeedback,
      'riderFeedback': riderFeedback,
      'requestTime': requestTime.toIso8601String(),
      'acceptTime': acceptTime?.toIso8601String(),
      'pickupTime': pickupTime?.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }

  // Helper to determine if ride is active
  bool get isActive {
    return status == 'pending' ||
        status == 'accepted' ||
        status == 'arrived_at_pickup' ||
        status == 'started';
  }

  // Helper to determine if ride is completed
  bool get isCompleted {
    return status == 'completed';
  }

  // Helper to determine if ride is cancelled
  bool get isCancelled {
    return status == 'cancelled';
  }
}

class LocationPoint {
  final String address;
  final GeoLocation location;

  LocationPoint({
    required this.address,
    required this.location,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      address: json['address'],
      location: GeoLocation.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'location': location.toJson(),
    };
  }
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

class Fare {
  final double baseFare;
  final double distanceFare;
  final double timeFare;
  final double totalFare;
  final String currency;

  Fare({
    required this.baseFare,
    required this.distanceFare,
    required this.timeFare,
    required this.totalFare,
    required this.currency,
  });

  factory Fare.fromJson(Map<String, dynamic> json) {
    return Fare(
      baseFare: json['baseFare'].toDouble(),
      distanceFare: json['distanceFare'].toDouble(),
      timeFare: json['timeFare'].toDouble(),
      totalFare: json['totalFare'].toDouble(),
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseFare': baseFare,
      'distanceFare': distanceFare,
      'timeFare': timeFare,
      'totalFare': totalFare,
      'currency': currency,
    };
  }
}

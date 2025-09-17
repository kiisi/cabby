import 'package:equatable/equatable.dart';

abstract class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object?> get props => [];
}

class RequestRide extends RideEvent {
  final String pickupAddress;
  final double pickupLat;
  final double pickupLng;
  final String destinationAddress;
  final double destinationLat;
  final double destinationLng;
  final String? paymentMethod;

  const RequestRide({
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationAddress,
    required this.destinationLat,
    required this.destinationLng,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        pickupAddress,
        pickupLat,
        pickupLng,
        destinationAddress,
        destinationLat,
        destinationLng,
        paymentMethod,
      ];
}

class GetNearbyDrivers extends RideEvent {
  final double latitude;
  final double longitude;
  final int radius;

  const GetNearbyDrivers({
    required this.latitude,
    required this.longitude,
    this.radius = 5,
  });

  @override
  List<Object?> get props => [latitude, longitude, radius];
}

class GetActiveRide extends RideEvent {}

class CancelRide extends RideEvent {
  final String rideId;
  final String? reason;

  const CancelRide({
    required this.rideId,
    this.reason,
  });

  @override
  List<Object?> get props => [rideId, reason];
}

class RateDriver extends RideEvent {
  final String rideId;
  final double rating;
  final String? feedback;

  const RateDriver({
    required this.rideId,
    required this.rating,
    this.feedback,
  });

  @override
  List<Object?> get props => [rideId, rating, feedback];
}

class ConnectToRideUpdates extends RideEvent {
  final String rideId;

  const ConnectToRideUpdates({
    required this.rideId,
  });

  @override
  List<Object?> get props => [rideId];
}

class DisconnectFromRideUpdates extends RideEvent {
  final String rideId;

  const DisconnectFromRideUpdates({
    required this.rideId,
  });

  @override
  List<Object?> get props => [rideId];
}

class DriverLocationUpdated extends RideEvent {
  final Map<String, dynamic> locationData;

  const DriverLocationUpdated({
    required this.locationData,
  });

  @override
  List<Object?> get props => [locationData];
}

class RideAccepted extends RideEvent {
  final Map<String, dynamic> acceptData;

  const RideAccepted({
    required this.acceptData,
  });

  @override
  List<Object?> get props => [acceptData];
}

class DriverArrived extends RideEvent {
  final Map<String, dynamic> arrivalData;

  const DriverArrived({
    required this.arrivalData,
  });

  @override
  List<Object?> get props => [arrivalData];
}

class RideStarted extends RideEvent {
  final Map<String, dynamic> startData;

  const RideStarted({
    required this.startData,
  });

  @override
  List<Object?> get props => [startData];
}

class RideCompleted extends RideEvent {
  final Map<String, dynamic> completionData;

  const RideCompleted({
    required this.completionData,
  });

  @override
  List<Object?> get props => [completionData];
}

class RideCancelled extends RideEvent {
  final Map<String, dynamic> cancellationData;

  const RideCancelled({
    required this.cancellationData,
  });

  @override
  List<Object?> get props => [cancellationData];
}

class SendMessage extends RideEvent {
  final String rideId;
  final String message;

  const SendMessage({
    required this.rideId,
    required this.message,
  });

  @override
  List<Object?> get props => [rideId, message];
}

class MessageReceived extends RideEvent {
  final Map<String, dynamic> messageData;

  const MessageReceived({
    required this.messageData,
  });

  @override
  List<Object?> get props => [messageData];
}

class GetRideHistory extends RideEvent {
  final int page;
  final int limit;

  const GetRideHistory({
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [page, limit];
}

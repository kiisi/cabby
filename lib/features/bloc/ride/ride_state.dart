import 'package:cabby/domain/models/driver_model.dart';
import 'package:cabby/domain/models/ride_model.dart' hide GeoLocation;
import 'package:equatable/equatable.dart';

abstract class RideState extends Equatable {
  const RideState();

  @override
  List<Object?> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class DriverSearching extends RideState {
  final RideModel ride;

  const DriverSearching(this.ride);

  @override
  List<Object?> get props => [ride];
}

class NearbyDriversLoaded extends RideState {
  final List<DriverModel> drivers;

  const NearbyDriversLoaded(this.drivers);

  @override
  List<Object?> get props => [drivers];
}

class RideAcceptedState extends RideState {
  final RideModel ride;
  final DriverModel driver;
  final String estimatedArrivalTime;

  const RideAcceptedState({
    required this.ride,
    required this.driver,
    required this.estimatedArrivalTime,
  });

  @override
  List<Object?> get props => [ride, driver, estimatedArrivalTime];
}

class DriverArrivedState extends RideState {
  final RideModel ride;

  const DriverArrivedState(this.ride);

  @override
  List<Object?> get props => [ride];
}

class RideInProgressState extends RideState {
  final RideModel ride;
  final GeoLocation? driverLocation;

  const RideInProgressState({
    required this.ride,
    this.driverLocation,
  });

  @override
  List<Object?> get props => [ride, driverLocation];
}

class RideCompletedState extends RideState {
  final RideModel ride;

  const RideCompletedState(this.ride);

  @override
  List<Object?> get props => [ride];
}

class RideCancelledState extends RideState {
  final RideModel ride;
  final String reason;
  final String cancelledBy;

  const RideCancelledState({
    required this.ride,
    required this.reason,
    required this.cancelledBy,
  });

  @override
  List<Object?> get props => [ride, reason, cancelledBy];
}

class RideHistoryLoaded extends RideState {
  final List<RideModel> rides;
  final int totalRides;
  final int currentPage;
  final int totalPages;

  const RideHistoryLoaded({
    required this.rides,
    required this.totalRides,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [rides, totalRides, currentPage, totalPages];
}

class RideFailure extends RideState {
  final String error;

  const RideFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class NewMessageReceived extends RideState {
  final String rideId;
  final String senderId;
  final String senderRole;
  final String message;
  final DateTime timestamp;

  const NewMessageReceived({
    required this.rideId,
    required this.senderId,
    required this.senderRole,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [rideId, senderId, senderRole, message, timestamp];
}

import 'package:cabby/features/bloc/location/location_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng currentLocation;
  final LatLng? pickupLocation;
  final LatLng? destinationLocation;
  final String? pickupAddress;
  final String? destinationAddress;
  final List<LocationPrediction> searchResults;
  final String? errorMessage;

  const LocationLoaded({
    required this.currentLocation,
    this.pickupLocation,
    this.destinationLocation,
    this.pickupAddress,
    this.destinationAddress,
    this.searchResults = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        currentLocation,
        pickupLocation,
        destinationLocation,
        pickupAddress,
        destinationAddress,
        searchResults,
        errorMessage,
      ];

  LocationLoaded copyWith({
    LatLng? currentLocation,
    LatLng? pickupLocation,
    LatLng? destinationLocation,
    String? pickupAddress,
    String? destinationAddress,
    List<LocationPrediction>? searchResults,
    String? errorMessage,
  }) {
    return LocationLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage,
    );
  }
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}

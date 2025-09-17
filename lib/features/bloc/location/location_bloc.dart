import 'dart:async';
import 'package:cabby/core/utils/location_service.dart';
import 'package:cabby/features/bloc/location/location_event.dart';
import 'package:cabby/features/bloc/location/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Location Bloc
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService locationService;
  StreamSubscription? _locationSubscription;

  LocationBloc({required this.locationService}) : super(LocationInitial()) {
    on<GetCurrentLocation>(_onGetCurrentLocation);
    on<LocationUpdated>(_onLocationUpdated);
    on<SearchLocation>(_onSearchLocation);
    on<SetPickupLocation>(_onSetPickupLocation);
    on<SetDestinationLocation>(_onSetDestinationLocation);
    on<ClearLocations>(_onClearLocations);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final position = await locationService.getCurrentLocation();

      // Convert to LatLng for Google Maps
      final latLng = LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0);

      // Subscribe to location updates
      _locationSubscription?.cancel();
      _locationSubscription = locationService.getLocationStream().listen(
            (position) => add(LocationUpdated(LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0))),
          );

      emit(LocationLoaded(currentLocation: latLng));
    } catch (error) {
      emit(LocationError(error.toString()));
    }
  }

  Future<void> _onLocationUpdated(
    LocationUpdated event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(currentLocation: event.position));
    }
  }

  Future<void> _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;

      if (event.query.isEmpty) {
        emit(currentState.copyWith(searchResults: []));
        return;
      }

      try {
        emit(currentState.copyWith(searchResults: []));

        final results = await locationService.searchPlaces(event.query);

        emit(currentState.copyWith(searchResults: results));
      } catch (error) {
        emit(currentState.copyWith(
          searchResults: [],
          errorMessage: error.toString(),
        ));
      }
    }
  }

  Future<void> _onSetPickupLocation(
    SetPickupLocation event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(
        pickupLocation: event.position,
        pickupAddress: event.address,
      ));
    }
  }

  Future<void> _onSetDestinationLocation(
    SetDestinationLocation event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(
        destinationLocation: event.position,
        destinationAddress: event.address,
      ));
    }
  }

  Future<void> _onClearLocations(
    ClearLocations event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(
        pickupLocation: null,
        destinationLocation: null,
        pickupAddress: null,
        destinationAddress: null,
        searchResults: [],
      ));
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}

class LocationPrediction {
  final String id;
  final String description;
  final String mainText;
  final String secondaryText;

  LocationPrediction({
    required this.id,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });
}

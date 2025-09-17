import 'package:cabby/features/bloc/location/location_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLocation extends LocationEvent {}

class LocationUpdated extends LocationEvent {
  final LatLng position;

  const LocationUpdated(this.position);

  @override
  List<Object> get props => [position];
}

class SearchLocation extends LocationEvent {
  final String query;

  const SearchLocation(this.query);

  @override
  List<Object> get props => [query];
}

class SetPickupLocation extends LocationEvent {
  final LatLng position;
  final String address;

  const SetPickupLocation({required this.position, required this.address});

  @override
  List<Object> get props => [position, address];
}

class SetDestinationLocation extends LocationEvent {
  final LatLng position;
  final String address;

  const SetDestinationLocation({required this.position, required this.address});

  @override
  List<Object> get props => [position, address];
}

class ClearLocations extends LocationEvent {}

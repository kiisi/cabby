part of 'location_service_bloc.dart';

class LocationServiceState {
  final bool? isLocationEnabled;

  LocationServiceState({this.isLocationEnabled});

  LocationServiceState copyWith({bool? isLocationEnabled}) {
    return LocationServiceState(
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
    );
  }
}

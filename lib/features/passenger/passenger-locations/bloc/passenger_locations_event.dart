part of 'passenger_locations_bloc.dart';

@immutable
abstract class PassengerLocationsEvent {}

class PassengerLocationsPickup extends PassengerLocationsEvent {
  final double latitude;
  final double longitude;

  PassengerLocationsPickup({required this.latitude, required this.longitude});
}

class PassengerLocationsDestination extends PassengerLocationsEvent {
  final double latitude;
  final double longitude;

  PassengerLocationsDestination(
      {required this.latitude, required this.longitude});
}

class LocationAutoCompleteSearch extends PassengerLocationsEvent {
  final String? input;
  final InputFocus inputFocus;

  LocationAutoCompleteSearch({required this.input, required this.inputFocus});
}

class PassengerLocationDetails extends PassengerLocationsEvent {
  final String? placeId;
  final InputFocus inputFocus;

  PassengerLocationDetails({required this.placeId, required this.inputFocus});
}

class LocationsInputUpdater extends PassengerLocationsEvent {
  final String? input;
  final InputFocus inputFocus;

  LocationsInputUpdater({required this.input, required this.inputFocus});
}

class PassengerLocationDirection extends PassengerLocationsEvent {
  final LatLng origin;
  final LatLng destination;

  PassengerLocationDirection({
    required this.origin,
    required this.destination,
  });
}

class PassengerLoadingStatusIdle extends PassengerLocationsEvent {}

class PassengerLocationsPickupDiscard extends PassengerLocationsEvent {}

class PassengerLocationsDestinationDiscard extends PassengerLocationsEvent {}

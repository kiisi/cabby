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

  LocationAutoCompleteSearch({required this.input});
}

class PassengerLocationDetails extends PassengerLocationsEvent {
  final String? placeId;
  final InputFocus inputFocus;

  PassengerLocationDetails({required this.placeId, required this.inputFocus});
}

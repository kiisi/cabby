part of 'passenger_locations_bloc.dart';

class PassengerLocationsState {
  final LocationDirection? pickupLocation;
  final LocationDirection? destinationLocation;
  final List<LocationPredictionAutoComplete?>? locationPredictionAutoComplete;

  PassengerLocationsState({
    this.pickupLocation,
    this.destinationLocation,
    this.locationPredictionAutoComplete,
  });

  PassengerLocationsState copyWith({
    LocationDirection? pickupLocation,
    LocationDirection? destinationLocation,
    List<LocationPredictionAutoComplete>? locationPredictionAutoComplete,
  }) {
    return PassengerLocationsState(
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      locationPredictionAutoComplete:
          locationPredictionAutoComplete ?? this.locationPredictionAutoComplete,
    );
  }
}

part of 'passenger_locations_bloc.dart';

class PassengerLocationsState {
  final String? pickupLocationInputText;
  final String? destinationLocationInputText;
  final LocationDetails? pickupLocation;
  final LocationDetails? destinationLocation;
  final List<LocationPredictionAutoComplete?>? locationPredictionAutoComplete;
  final LocationDirection? locationDirection;
  LoadingStatus? loadingStatus = LoadingStatus.idle;
  // Map<PolylineId, Polyline> polylines;
  Set<Polyline> polylineSet;

  PassengerLocationsState({
    this.pickupLocationInputText,
    this.destinationLocationInputText,
    this.pickupLocation,
    this.destinationLocation,
    this.locationPredictionAutoComplete,
    this.locationDirection,
    this.loadingStatus,
    // this.polylines = const {},
    this.polylineSet = const {},
  });

  PassengerLocationsState copyWith({
    String? pickupLocationInputText,
    String? destinationLocationInputText,
    LocationDetails? pickupLocation,
    LocationDetails? destinationLocation,
    List<LocationPredictionAutoComplete>? locationPredictionAutoComplete,
    LocationDirection? locationDirection,
    LoadingStatus? loadingStatus,
    // Map<PolylineId, Polyline>? polylines,
    Set<Polyline>? polylineSet,
  }) {
    return PassengerLocationsState(
      pickupLocationInputText:
          pickupLocationInputText ?? this.pickupLocationInputText,
      destinationLocationInputText:
          destinationLocationInputText ?? this.destinationLocationInputText,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      locationPredictionAutoComplete:
          locationPredictionAutoComplete ?? this.locationPredictionAutoComplete,
      locationDirection: locationDirection ?? this.locationDirection,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      // polylines: polylines ?? this.polylines,
      polylineSet: polylineSet ?? this.polylineSet,
    );
  }
}

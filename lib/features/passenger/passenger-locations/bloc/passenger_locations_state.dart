part of 'passenger_locations_bloc.dart';

class PassengerLocationsState {
  final String? pickupLocationInputText;
  final String? destinationLocationInputText;
  final LocationDetails? pickupLocation;
  final LocationDetails? destinationLocation;
  final List<LocationPredictionAutoComplete?>? locationPredictionAutoComplete;
  final LocationDirection? locationDirection;
  // Map<PolylineId, Polyline> polylines;
  Set<Polyline> polylineSet;
  int? estimatedFareValue;
  String? estimatedFareCurrency;
  LoadingStatus? locationDetailsLoadingStatus;
  LoadingStatus? estimatedFareLoadingStatus;
  LoadingStatus? extraLoadingStatus;

  PassengerLocationsState({
    this.pickupLocationInputText,
    this.destinationLocationInputText,
    this.pickupLocation,
    this.destinationLocation,
    this.locationPredictionAutoComplete,
    this.locationDirection,
    this.locationDetailsLoadingStatus,
    this.extraLoadingStatus,
    // this.polylines = const {},
    this.polylineSet = const {},
    this.estimatedFareValue,
    this.estimatedFareCurrency,
    this.estimatedFareLoadingStatus,
  });

  PassengerLocationsState copyWith(
      {String? pickupLocationInputText,
      String? destinationLocationInputText,
      LocationDetails? pickupLocation,
      LocationDetails? destinationLocation,
      List<LocationPredictionAutoComplete>? locationPredictionAutoComplete,
      LocationDirection? locationDirection,
      LoadingStatus? locationDetailsLoadingStatus,
      LoadingStatus? extraLoadingStatus,
      // Map<PolylineId, Polyline>? polylines,
      Set<Polyline>? polylineSet,
      int? estimatedFareValue,
      String? estimatedFareCurrency,
      LoadingStatus? estimatedFareLoadingStatus}) {
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
      locationDetailsLoadingStatus:
          locationDetailsLoadingStatus ?? this.locationDetailsLoadingStatus,
      extraLoadingStatus: extraLoadingStatus ?? this.extraLoadingStatus,
      // polylines: polylines ?? this.polylines,
      polylineSet: polylineSet ?? this.polylineSet,
      estimatedFareValue: estimatedFareValue ?? this.estimatedFareValue,
      estimatedFareCurrency:
          estimatedFareCurrency ?? this.estimatedFareCurrency,
      estimatedFareLoadingStatus:
          estimatedFareLoadingStatus ?? this.estimatedFareLoadingStatus,
    );
  }

  PassengerLocationsState copyWithDestinationLocationSetToNull(
      {String? pickupLocationInputText,
      String? destinationLocationInputText,
      LocationDetails? pickupLocation,
      LocationDetails? destinationLocation,
      List<LocationPredictionAutoComplete>? locationPredictionAutoComplete,
      LocationDirection? locationDirection,
      LoadingStatus? locationDetailsLoadingStatus,
      // Map<PolylineId, Polyline>? polylines,
      Set<Polyline>? polylineSet,
      int? estimatedFareValue,
      String? estimatedFareCurrency,
      LoadingStatus? estimatedFareLoadingStatus}) {
    return PassengerLocationsState(
      pickupLocationInputText:
          pickupLocationInputText ?? this.pickupLocationInputText,
      destinationLocationInputText: null,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: null,
      locationPredictionAutoComplete: null,
      locationDirection: locationDirection ?? this.locationDirection,
      locationDetailsLoadingStatus:
          locationDetailsLoadingStatus ?? this.locationDetailsLoadingStatus,
      // polylines: polylines ?? this.polylines,
      polylineSet: polylineSet ?? this.polylineSet,
      estimatedFareValue: estimatedFareValue ?? this.estimatedFareValue,
      estimatedFareCurrency:
          estimatedFareCurrency ?? this.estimatedFareCurrency,
      estimatedFareLoadingStatus:
          estimatedFareLoadingStatus ?? this.estimatedFareLoadingStatus,
    );
  }

  PassengerLocationsState copyWithPickupLocationSetToNull(
      {String? pickupLocationInputText,
      String? destinationLocationInputText,
      LocationDetails? pickupLocation,
      LocationDetails? destinationLocation,
      List<LocationPredictionAutoComplete>? locationPredictionAutoComplete,
      LocationDirection? locationDirection,
      LoadingStatus? locationDetailsLoadingStatus,
      // Map<PolylineId, Polyline>? polylines,
      Set<Polyline>? polylineSet,
      int? estimatedFareValue,
      String? estimatedFareCurrency,
      LoadingStatus? estimatedFareLoadingStatus}) {
    return PassengerLocationsState(
      pickupLocationInputText: null,
      destinationLocationInputText:
          destinationLocationInputText ?? this.destinationLocationInputText,
      pickupLocation: null,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      locationPredictionAutoComplete: null,
      locationDirection: locationDirection ?? this.locationDirection,
      locationDetailsLoadingStatus:
          locationDetailsLoadingStatus ?? this.locationDetailsLoadingStatus,
      // polylines: polylines ?? this.polylines,
      polylineSet: polylineSet ?? this.polylineSet,
      estimatedFareValue: estimatedFareValue ?? this.estimatedFareValue,
      estimatedFareCurrency:
          estimatedFareCurrency ?? this.estimatedFareCurrency,
      estimatedFareLoadingStatus:
          estimatedFareLoadingStatus ?? this.estimatedFareLoadingStatus,
    );
  }
}

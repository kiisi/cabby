import 'package:cabby/data/network/app_api.dart';
import 'package:cabby/domain/models/google_maps.dart';

abstract interface class GoogleMapsRemoteDataSource {
  Future<dynamic> reverseGeoCode(ReverseGeoCodeQuery reverseGeoCodeQuery);

  Future<dynamic> autocompleteSearch(
      AutoCompleteSearchQuery autoCompleteSearchQuery);
  Future<dynamic> placeLocationDetails(
      PlaceLocationDetailsQuery placeLocationDetailsQuery);

  Future<dynamic> placeLocationDirection(
      PlaceLocationDirectionQuery placeLocationDirectionQuery);

  Future<dynamic> placeLocationRoute(
      PlaceLocationRouteQuery placeLocationRouteQuery);
}

class GoogleMapsRemoteDataSourceImpl implements GoogleMapsRemoteDataSource {
  final GoogleMapsServiceClient _googleMapsServiceClient;

  final GoogleMapsRouteServiceClient _googleMapsRouteServiceClient;

  GoogleMapsRemoteDataSourceImpl(
      this._googleMapsServiceClient, this._googleMapsRouteServiceClient);

  @override
  Future<dynamic> reverseGeoCode(
      ReverseGeoCodeQuery reverseGeoCodeQuery) async {
    return await _googleMapsServiceClient.reverseGeoCode(
      latlng: reverseGeoCodeQuery.latlng,
    );
  }

  @override
  Future autocompleteSearch(
      AutoCompleteSearchQuery autoCompleteSearchQuery) async {
    return await _googleMapsServiceClient.autoCompleteSearch(
      input: autoCompleteSearchQuery.input,
    );
  }

  @override
  Future placeLocationDetails(
      PlaceLocationDetailsQuery placeLocationDetailsQuery) async {
    return await _googleMapsServiceClient.placeLocationDetails(
      placeId: placeLocationDetailsQuery.placeId,
    );
  }

  @override
  Future placeLocationDirection(
      PlaceLocationDirectionQuery placeLocationDirectionQuery) async {
    return await _googleMapsServiceClient.placeLocationDirection(
      destination: placeLocationDirectionQuery.destination,
      origin: placeLocationDirectionQuery.origin,
    );
  }

  @override
  Future placeLocationRoute(
      PlaceLocationRouteQuery placeLocationRouteQuery) async {
    return await _googleMapsRouteServiceClient.getRoute(
      destination: {
        "location": {
          "latLng": {
            "latitude": placeLocationRouteQuery.destination.latitude,
            "longitude": placeLocationRouteQuery.destination.longitude
          }
        }
      },
      origin: {
        "location": {
          "latLng": {
            "latitude": placeLocationRouteQuery.origin.latitude,
            "longitude": placeLocationRouteQuery.origin.longitude
          }
        }
      },
    );
  }
}

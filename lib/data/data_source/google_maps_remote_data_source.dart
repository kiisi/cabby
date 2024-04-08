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
}

class GoogleMapsRemoteDataSourceImpl implements GoogleMapsRemoteDataSource {
  final GoogleMapsServiceClient _googleMapsServiceClient;

  GoogleMapsRemoteDataSourceImpl(this._googleMapsServiceClient);

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
}

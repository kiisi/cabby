import 'package:cabby/data/network/app_api.dart';
import 'package:cabby/domain/models/google_maps.dart';

abstract interface class GoogleMapsRemoteDataSource {
  Future<dynamic> reverseGeoCode(ReverseGeoCodeQuery reverseGeoCodeQuery);

  Future<dynamic> autocompleteSearch(
      AutoCompleteSearchQuery autoCompleteSearchQuery);
  Future<dynamic> placeDirectionDetails(
      PlaceDirectionDetailsQuery placeDirectionDetailsQuery);
}

class GoogleMapsRemoteDataSourceImpl implements GoogleMapsRemoteDataSource {
  final GoogleMapsServiceClient _googleMapsServiceClient;

  GoogleMapsRemoteDataSourceImpl(this._googleMapsServiceClient);

  @override
  Future<dynamic> reverseGeoCode(
      ReverseGeoCodeQuery reverseGeoCodeQuery) async {
    return await _googleMapsServiceClient.reverseGeoCode(
      latlng: reverseGeoCodeQuery.latlng,
      key: reverseGeoCodeQuery.key,
    );
  }

  @override
  Future autocompleteSearch(
      AutoCompleteSearchQuery autoCompleteSearchQuery) async {
    return await _googleMapsServiceClient.autoCompleteSearch(
      input: autoCompleteSearchQuery.input,
      key: autoCompleteSearchQuery.key,
    );
  }

  @override
  Future placeDirectionDetails(
      PlaceDirectionDetailsQuery placeDirectionDetailsQuery) async {
    return await _googleMapsServiceClient.placeDirectionDetails(
      placeId: placeDirectionDetailsQuery.placeId,
      key: placeDirectionDetailsQuery.key,
    );
  }
}

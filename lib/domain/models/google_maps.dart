import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class ReverseGeoCodeQuery {
  final String latlng;

  ReverseGeoCodeQuery({required this.latlng});
}

class AutoCompleteSearchQuery {
  final String input;

  AutoCompleteSearchQuery({required this.input});
}

class PlaceLocationDetailsQuery {
  final String placeId;

  PlaceLocationDetailsQuery({required this.placeId});
}

class PlaceLocationDirectionQuery {
  final String destination;
  final String origin;

  PlaceLocationDirectionQuery(
      {required this.destination, required this.origin});
}

class OriginPlaceId {
  final String placeId;

  OriginPlaceId({required this.placeId});
}

class DestinationPlaceId {
  final String placeId;

  DestinationPlaceId({required this.placeId});
}

class PlaceLocationRouteQuery {
  final LatLng destination;
  final LatLng origin;

  PlaceLocationRouteQuery({required this.destination, required this.origin});
}

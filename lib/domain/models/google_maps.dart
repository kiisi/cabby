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

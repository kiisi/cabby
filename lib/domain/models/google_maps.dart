class ReverseGeoCodeQuery {
  final String latlng;
  final String key;

  ReverseGeoCodeQuery({required this.latlng, required this.key});
}

class AutoCompleteSearchQuery {
  final String input;
  final String key;

  AutoCompleteSearchQuery({required this.input, required this.key});
}

class PlaceDirectionDetailsQuery {
  final String placeId;
  final String key;

  PlaceDirectionDetailsQuery({required this.placeId, required this.key});
}

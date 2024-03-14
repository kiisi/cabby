class LocationDirection {
  final double latitude;
  final double longitude;
  final String address;

  LocationDirection(
      {required this.latitude, required this.longitude, required this.address});
}

class LocationPredictionAutoComplete {
  String? placeId;
  String? mainText;
  String? secondaryText;
  List<String>? locationType;

  LocationPredictionAutoComplete({
    this.placeId,
    this.mainText,
    this.secondaryText,
    this.locationType,
  });

  LocationPredictionAutoComplete.fromJson(Map<String, dynamic> jsonData) {
    placeId = jsonData['place_id'];
    mainText = jsonData['structured_formatting']['main_text'];
    secondaryText = jsonData['structured_formatting']['secondary_text'];
    locationType =
        (jsonData['types'] as List).map((e) => e.toString()).toList();
  }
}

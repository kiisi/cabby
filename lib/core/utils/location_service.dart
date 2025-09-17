import 'dart:async';
import 'dart:math' as math;
import 'package:cabby/features/bloc/location/location_bloc.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final Location _location = Location();
  final Dio _dio = Dio();

  StreamSubscription<LocationData>? _locationSubscription;
  StreamController<LocationData>? _locationController;

  // Initialize location service
  Future<void> initialize() async {
    // Request permissions
    final permissionStatus = await _location.requestPermission();
    if (permissionStatus == PermissionStatus.denied || permissionStatus == PermissionStatus.deniedForever) {
      throw Exception('Location permission denied');
    }

    // Configure location service
    await _location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000, // 1 second
      distanceFilter: 10, // 10 meters
    );
  }

  // Get current location
  Future<LocationData> getCurrentLocation() async {
    await initialize();

    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location service is disabled');
      }
    }

    final locationData = await _location.getLocation();
    return locationData;
  }

  // Get location stream for real-time updates
  Stream<LocationData> getLocationStream() {
    if (_locationController == null) {
      _locationController = StreamController<LocationData>.broadcast();
      _startLocationStream();
    }
    return _locationController!.stream;
  }

  void _startLocationStream() async {
    try {
      await initialize();

      _locationSubscription = _location.onLocationChanged.listen(
        (LocationData locationData) {
          _locationController?.add(locationData);
        },
        onError: (error) {
          _locationController?.addError(error);
        },
      );
    } catch (e) {
      _locationController?.addError(e);
    }
  }

  // Search places using Google Places API (simplified)
  Future<List<LocationPrediction>> searchPlaces(String query) async {
    try {
      // In a real app, you would use Google Places API here
      // For now, we'll return mock data
      await Future.delayed(const Duration(milliseconds: 500));

      if (query.isEmpty) return [];

      // Mock search results based on query
      return _generateMockSearchResults(query);
    } catch (e) {
      throw Exception('Failed to search places: $e');
    }
  }

  // Get place details by place ID (simplified)
  Future<PlaceDetails> getPlaceDetails(String placeId) async {
    try {
      // In a real app, you would use Google Places API here
      // For now, we'll return mock data
      await Future.delayed(const Duration(milliseconds: 300));

      return _generateMockPlaceDetails(placeId);
    } catch (e) {
      throw Exception('Failed to get place details: $e');
    }
  }

  // Calculate distance between two points
  double calculateDistance(LatLng start, LatLng end) {
    // Using Haversine formula for distance calculation
    const double earthRadius = 6371; // Earth's radius in kilometers

    double latDiff = _degreesToRadians(end.latitude - start.latitude);
    double lonDiff = _degreesToRadians(end.longitude - start.longitude);

    double a = math.sin(latDiff / 2) * math.sin(latDiff / 2) +
        math.cos(_degreesToRadians(start.latitude)) *
            math.cos(_degreesToRadians(end.latitude)) *
            math.sin(lonDiff / 2) *
            math.sin(lonDiff / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  // Mock data generators for development
  List<LocationPrediction> _generateMockSearchResults(String query) {
    final List<String> mockPlaces = [
      'Airport Terminal',
      'Shopping Mall',
      'Central Station',
      'City Hospital',
      'University Campus',
      'Business District',
      'Beach Resort',
      'Sports Stadium',
      'Art Museum',
      'Convention Center',
    ];

    return mockPlaces
        .where((place) => place.toLowerCase().contains(query.toLowerCase()))
        .take(5)
        .map((place) => LocationPrediction(
              id: place.replaceAll(' ', '_').toLowerCase(),
              description: '$place, City Center',
              mainText: place,
              secondaryText: 'City Center',
            ))
        .toList();
  }

  PlaceDetails _generateMockPlaceDetails(String placeId) {
    // Generate mock coordinates based on place ID
    final hash = placeId.hashCode;
    final latitude = 37.7749 + (hash % 1000) / 10000.0; // San Francisco area
    final longitude = -122.4194 + (hash % 1000) / 10000.0;

    return PlaceDetails(
      latitude: latitude,
      longitude: longitude,
      address: placeId.replaceAll('_', ' ').toUpperCase() + ', City Center',
    );
  }

  // Dispose resources
  void dispose() {
    _locationSubscription?.cancel();
    _locationController?.close();
    _locationController = null;
  }
}

// Helper classes
class PlaceDetails {
  final double latitude;
  final double longitude;
  final String address;

  PlaceDetails({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

// Import math for distance calculations

import 'dart:async';

import 'package:cabby/app/app_config.dart';
import 'package:cabby/data/providers/api_provider.dart';
import 'package:cabby/data/providers/socket_provider.dart';
import 'package:cabby/domain/models/driver_model.dart';
import 'package:cabby/domain/models/ride_model.dart';

class RideRepository {
  final ApiProvider apiProvider;
  final SocketProvider socketProvider;

  RideRepository({
    required this.apiProvider,
    required this.socketProvider,
  });

  // Request a new ride
  Future<RideModel> requestRide({
    required String pickupAddress,
    required double pickupLat,
    required double pickupLng,
    required String destinationAddress,
    required double destinationLat,
    required double destinationLng,
    String? paymentMethod,
  }) async {
    try {
      final response = await apiProvider.post(
        '/rides/request',
        data: {
          'pickupAddress': pickupAddress,
          'pickupLat': pickupLat,
          'pickupLng': pickupLng,
          'destinationAddress': destinationAddress,
          'destinationLat': destinationLat,
          'destinationLng': destinationLng,
          'paymentMethod': paymentMethod ?? 'cash',
        },
      );

      return RideModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to request ride: ${e.toString()}');
    }
  }

  // Get nearby drivers
  Future<List<DriverModel>> getNearbyDrivers({
    required double latitude,
    required double longitude,
    int radius = AppConfig.defaultSearchRadius,
  }) async {
    try {
      final response = await apiProvider.get(
        '/rides/nearby-drivers',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'radius': radius,
        },
      );

      final List<dynamic> driversJson = response.data['data'];
      return driversJson.map((json) => DriverModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get nearby drivers: ${e.toString()}');
    }
  }

  // Get active ride
  Future<RideModel?> getActiveRide() async {
    try {
      final response = await apiProvider.get('/rides/active');
      return RideModel.fromJson(response.data['data']);
    } catch (e) {
      if (e.toString().contains('404')) {
        // No active ride found
        return null;
      }
      throw Exception('Failed to get active ride: ${e.toString()}');
    }
  }

  // Get ride by ID
  Future<RideModel> getRideById(String rideId) async {
    try {
      final response = await apiProvider.get('/users/rides/$rideId');
      return RideModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get ride: ${e.toString()}');
    }
  }

  // Get ride history
  Future<List<RideModel>> getRideHistory({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await apiProvider.get(
        '/users/rides',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final List<dynamic> ridesJson = response.data['data'];
      return ridesJson.map((json) => RideModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get ride history: ${e.toString()}');
    }
  }

  // Cancel ride
  Future<void> cancelRide(String rideId, {String? reason}) async {
    try {
      await apiProvider.put(
        '/rides/$rideId/cancel',
        data: {
          'reason': reason,
        },
      );
    } catch (e) {
      throw Exception('Failed to cancel ride: ${e.toString()}');
    }
  }

  // Rate driver
  Future<void> rateDriver({
    required String rideId,
    required double rating,
    String? feedback,
  }) async {
    try {
      await apiProvider.post(
        '/users/rate-driver',
        data: {
          'rideId': rideId,
          'rating': rating,
          'feedback': feedback,
        },
      );
    } catch (e) {
      throw Exception('Failed to rate driver: ${e.toString()}');
    }
  }

  // Listen for ride updates
  Stream<Map<String, dynamic>> listenForRideAccepted() {
    return socketProvider.listenToEvent(AppConfig.eventRideAccepted);
  }

  Stream<Map<String, dynamic>> listenForDriverLocation() {
    return socketProvider.listenToEvent(AppConfig.eventDriverLocation);
  }

  Stream<Map<String, dynamic>> listenForDriverArrived() {
    return socketProvider.listenToEvent(AppConfig.eventDriverArrived);
  }

  Stream<Map<String, dynamic>> listenForRideStarted() {
    return socketProvider.listenToEvent(AppConfig.eventRideStarted);
  }

  Stream<Map<String, dynamic>> listenForRideCompleted() {
    return socketProvider.listenToEvent(AppConfig.eventRideCompleted);
  }

  Stream<Map<String, dynamic>> listenForRideCancelled() {
    return socketProvider.listenToEvent(AppConfig.eventRideCancelled);
  }

  Stream<Map<String, dynamic>> listenForNewMessage() {
    return socketProvider.listenToEvent(AppConfig.eventNewMessage);
  }

  // Send a message
  void sendMessage(String rideId, String message) {
    socketProvider.emitEvent('send_message', {
      'rideId': rideId,
      'message': message,
    });
  }

  // Connect to specific ride room
  void connectToRideRoom(String rideId) {
    socketProvider.emitEvent('join_ride', {'rideId': rideId});
  }

  // Disconnect from specific ride room
  void disconnectFromRideRoom(String rideId) {
    socketProvider.emitEvent('leave_ride', {'rideId': rideId});
  }
}

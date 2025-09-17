import 'package:flutter/material.dart';

class AppConfig {
  // App information
  static const String appName = 'Cabby Rider';
  static const String appVersion = '1.0.0';

  // API configuration
  static const String apiUrl = 'http://192.168.43.217:5000/api/v1';
  static const String socketUrl = 'http://192.168.43.217:5000';

  // UI configuration
  static const Color primaryColor = Color(0xFF1E88E5); // Blue
  static const Color accentColor = Color(0xFFFFA000); // Amber
  static const Color onlineColor = Color(0xFF4CAF50); // Green
  static const Color offlineColor = Color(0xFF9E9E9E); // Grey
  static const double screenPadding = 16.0;
  static const double cardBorderRadius = 12.0;

  // Map configuration
  static const double defaultZoom = 15.0;
  static const double navigationZoom = 17.0;

  // Location update configuration
  static const Duration locationUpdateInterval = Duration(seconds: 15);

  // Driver settings
  static const double maxDriverSearchRadius = 5.0; // kilometers
  static const Duration rideRequestTimeout = Duration(seconds: 30);

  // Payment methods supported
  static const List<String> paymentMethods = ['cash', 'card'];

  // Vehicle types
  static const Map<String, String> vehicleTypes = {
    'economy': 'Economy',
    'comfort': 'Comfort',
    'premium': 'Premium',
  };

  // Ride status codes
  static const String rideStatusPending = 'pending';
  static const String rideStatusAccepted = 'accepted';
  static const String rideStatusArrived = 'arrived';
  static const String rideStatusInProgress = 'in_progress';
  static const String rideStatusCompleted = 'completed';
  static const String rideStatusCancelled = 'cancelled';

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String onlineStatusKey = 'online_status';

  // Error messages
  static const String networkErrorMessage = 'Network error. Please check your connection and try again.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String authErrorMessage = 'Authentication error. Please log in again.';

  // Success messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registerSuccessMessage = 'Registration successful!';
  static const String rideCompletedMessage = 'Ride completed successfully!';

  // Feature flags
  static const bool enableChat = true;
  static const bool enableDocumentUpload = true;
  static const bool enableInAppNotifications = true;

  // Map Config
  static const double defaultLatitude = 37.7749; // Default location (San Francisco)
  static const double defaultLongitude = -122.4194;

  // Ride Config
  static const int defaultSearchRadius = 5; // In kilometers
  static const int maxWaitingTimeForDriver = 120; // In seconds

  // Payment Config
  static const String defaultCurrency = 'USD';
  static const List<String> availablePaymentMethods = ['cash', 'card'];

  // App Layout
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 8.0;

  // Animation Duration
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 1000);

  // Strings
  static const String appSlogan = 'Your ride, your way';

  // Images
  static const String logoPath = 'assets/logo.png';
  static const String markerIconPath = 'assets/marker.png';
  static const String carIconPath = 'assets/car.png';

  // Socket Events
  static const String eventDriverLocation = 'driver_location';
  static const String eventRideAccepted = 'ride_accepted';
  static const String eventDriverArrived = 'driver_arrived';
  static const String eventRideStarted = 'ride_started';
  static const String eventRideCompleted = 'ride_completed';
  static const String eventRideCancelled = 'ride_cancelled';
  static const String eventNewMessage = 'new_message';
  static const String eventPaymentCompleted = 'payment_completed';
}

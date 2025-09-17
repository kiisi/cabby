import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_config.dart';
import 'package:cabby/features/bloc/location/location_bloc.dart';
import 'package:cabby/features/bloc/location/location_state.dart';
import 'package:cabby/features/bloc/ride/ride_bloc.dart';
import 'package:cabby/features/bloc/ride/ride_event.dart';
import 'package:cabby/features/bloc/ride/ride_state.dart';
import 'package:cabby/features/ride_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

@RoutePage()
class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({Key? key}) : super(key: key);

  @override
  _RideBookingScreenState createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  String _selectedPaymentMethod = 'cash';
  String _selectedVehicleType = 'economy';

  // Estimated price for different vehicle types
  Map<String, double> _priceMultipliers = {
    'economy': 1.0,
    'comfort': 1.3,
    'premium': 1.8,
  };

  @override
  void initState() {
    super.initState();

    // Get nearby drivers when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationState = context.read<LocationBloc>().state;

      if (locationState is LocationLoaded && locationState.pickupLocation != null) {
        context.read<RideBloc>().add(
              GetNearbyDrivers(
                latitude: locationState.pickupLocation!.latitude,
                longitude: locationState.pickupLocation!.longitude,
              ),
            );
      }
    });
  }

  double _getBaseFare() {
    return 2.50;
  }

  double _getDistanceFare(double distance) {
    return distance * 1.25;
  }

  double _getTimeFare(int duration) {
    return duration * 0.35;
  }

  double _calculateTotalFare(double distance, int duration, String vehicleType) {
    final baseFare = _getBaseFare();
    final distanceFare = _getDistanceFare(distance);
    final timeFare = _getTimeFare(duration);
    final subtotal = baseFare + distanceFare + timeFare;

    return subtotal * _priceMultipliers[vehicleType]!;
  }

  void _requestRide() {
    final locationState = context.read<LocationBloc>().state;

    if (locationState is LocationLoaded &&
        locationState.pickupLocation != null &&
        locationState.destinationLocation != null) {
      context.read<RideBloc>().add(
            RequestRide(
              pickupAddress: locationState.pickupAddress ?? 'Unknown location',
              pickupLat: locationState.pickupLocation!.latitude,
              pickupLng: locationState.pickupLocation!.longitude,
              destinationAddress: locationState.destinationAddress ?? 'Unknown location',
              destinationLat: locationState.destinationLocation!.latitude,
              destinationLng: locationState.destinationLocation!.longitude,
              paymentMethod: _selectedPaymentMethod,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
      ),
      body: BlocListener<RideBloc, RideState>(
        listener: (context, state) {
          if (state is DriverSearching) {
            // Navigate to tracking screen when ride is requested
            Navigator.of(context).pushReplacementNamed('/ride-tracking');
          } else if (state is RideFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            if (locationState is! LocationLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            if (locationState.pickupLocation == null || locationState.destinationLocation == null) {
              return const Center(
                child: Text('Pickup or destination location not selected'),
              );
            }

            // Calculate distance and duration between pickup and destination
            final double distance = _calculateDistance(
              locationState.pickupLocation!,
              locationState.destinationLocation!,
            );

            final int duration = _estimateDuration(distance);

            return Column(
              children: [
                // Map preview
                Container(
                  height: 200,
                  child: MapWidget(
                    currentLocation: locationState.currentLocation,
                    pickupLocation: locationState.pickupLocation,
                    destinationLocation: locationState.destinationLocation,
                    showDirections: true,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Ride details card
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConfig.cardBorderRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ride Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Pickup location
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        locationState.pickupAddress ?? 'Pickup location',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Dotted line
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.grey[300],
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Destination location
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        locationState.destinationAddress ?? 'Destination location',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(height: 32),

                                // Distance and time
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Distance',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${distance.toStringAsFixed(1)} km',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Est. Time',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatDuration(duration),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Vehicle type selection
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConfig.cardBorderRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Vehicle Type',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Economy option
                                _buildVehicleTypeOption(
                                  'economy',
                                  'Economy',
                                  Icons.directions_car,
                                  'Standard cars, affordable rides',
                                  _calculateTotalFare(distance, duration, 'economy'),
                                ),

                                const SizedBox(height: 8),

                                // Comfort option
                                _buildVehicleTypeOption(
                                  'comfort',
                                  'Comfort',
                                  Icons.directions_car,
                                  'More spacious cars, extra comfort',
                                  _calculateTotalFare(distance, duration, 'comfort'),
                                ),

                                const SizedBox(height: 8),

                                // Premium option
                                _buildVehicleTypeOption(
                                  'premium',
                                  'Premium',
                                  Icons.airport_shuttle,
                                  'Luxury cars, top-rated drivers',
                                  _calculateTotalFare(distance, duration, 'premium'),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Payment method selection
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConfig.cardBorderRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Payment Method',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Cash option
                                RadioListTile<String>(
                                  title: const Row(
                                    children: [
                                      Icon(Icons.money, color: AppConfig.primaryColor),
                                      SizedBox(width: 8),
                                      Text('Cash'),
                                    ],
                                  ),
                                  value: 'cash',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPaymentMethod = value!;
                                    });
                                  },
                                  activeColor: AppConfig.primaryColor,
                                ),

                                // Card option (disabled for now)
                                RadioListTile<String>(
                                  title: const Row(
                                    children: [
                                      Icon(Icons.credit_card, color: Colors.grey),
                                      SizedBox(width: 8),
                                      Text('Credit/Debit Card'),
                                    ],
                                  ),
                                  subtitle: const Text('Coming soon'),
                                  value: 'card',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: null, // Disabled
                                  activeColor: AppConfig.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Request ride button
                        BlocBuilder<RideBloc, RideState>(
                          builder: (context, rideState) {
                            return ElevatedButton.icon(
                              onPressed: rideState is RideLoading ? null : _requestRide,
                              icon: rideState is RideLoading
                                  ? Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Icon(Icons.local_taxi),
                              label: Text(
                                rideState is RideLoading
                                    ? 'Requesting Ride...'
                                    : 'Request ${_formatVehicleType(_selectedVehicleType)} - \$${_calculateTotalFare(distance, duration, _selectedVehicleType).toStringAsFixed(2)}',
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildVehicleTypeOption(
    String value,
    String title,
    IconData icon,
    String description,
    double price,
  ) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(title),
          const Spacer(),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: Text(description),
      value: value,
      groupValue: _selectedVehicleType,
      onChanged: (value) {
        setState(() {
          _selectedVehicleType = value!;
        });
      },
      activeColor: AppConfig.primaryColor,
    );
  }

  // Helper function to calculate distance between two points
  double _calculateDistance(LatLng point1, LatLng point2) {
    // This is a simplified calculation - in a real app, you'd use the Haversine formula
    // or request the actual distance from a routing service
    const double earthRadius = 6371; // in kilometers

    final lat1 = point1.latitude * (pi / 180);
    final lon1 = point1.longitude * (pi / 180);
    final lat2 = point2.latitude * (pi / 180);
    final lon2 = point2.longitude * (pi / 180);

    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;

    final a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  // Helper function to estimate duration based on distance
  int _estimateDuration(double distance) {
    // Assuming an average speed of 30 km/h
    // Plus 5 minutes for pickup
    return (distance / 0.5).round() + 5;
  }

  // Helper function to format duration
  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return '$hours h ${remainingMinutes > 0 ? '$remainingMinutes min' : ''}';
    }
  }

  // Helper function to format vehicle type
  String _formatVehicleType(String vehicleType) {
    return vehicleType[0].toUpperCase() + vehicleType.substring(1);
  }
}

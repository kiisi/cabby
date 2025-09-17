import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_config.dart';
import 'package:cabby/core/utils/location_service.dart';
import 'package:cabby/features/bloc/location/location_bloc.dart';
import 'package:cabby/features/bloc/location/location_event.dart';
import 'package:cabby/features/bloc/location/location_state.dart';
import 'package:cabby/features/bloc/ride/ride_bloc.dart';
import 'package:cabby/features/bloc/ride/ride_event.dart';
import 'package:cabby/features/bloc/ride/ride_state.dart';
import 'package:cabby/features/ride_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class HomesScreen extends StatefulWidget {
  const HomesScreen({Key? key}) : super(key: key);

  @override
  _HomesScreenState createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();
  bool _isAddressSearch = false;
  bool _isSearchingForPickup = true;

  @override
  void initState() {
    super.initState();

    // Check for active ride when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize location bloc
      if (context.read<LocationBloc>().state is LocationInitial) {
        context.read<LocationBloc>().add(GetCurrentLocation());
      }

      // Check for active ride
      context.read<RideBloc>().add(GetActiveRide());
    });

    // Listen for focus changes
    _pickupFocusNode.addListener(_onPickupFocus);
    _destinationFocusNode.addListener(_onDestinationFocus);
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    _pickupFocusNode.removeListener(_onPickupFocus);
    _destinationFocusNode.removeListener(_onDestinationFocus);
    _pickupFocusNode.dispose();
    _destinationFocusNode.dispose();
    super.dispose();
  }

  void _onPickupFocus() {
    if (_pickupFocusNode.hasFocus) {
      setState(() {
        _isAddressSearch = true;
        _isSearchingForPickup = true;
      });
    }
  }

  void _onDestinationFocus() {
    if (_destinationFocusNode.hasFocus) {
      setState(() {
        _isAddressSearch = true;
        _isSearchingForPickup = false;
      });
    }
  }

  void _cancelSearch() {
    setState(() {
      _isAddressSearch = false;
    });
    FocusScope.of(context).unfocus();
  }

  void _searchLocation(String query) {
    context.read<LocationBloc>().add(SearchLocation(query));
  }

  void _selectLocation(LocationPrediction prediction) async {
    // Close the search UI
    setState(() {
      _isAddressSearch = false;
    });

    FocusScope.of(context).unfocus();

    // Get location details from prediction
    try {
      final details = await LocationService().getPlaceDetails(prediction.id);

      if (_isSearchingForPickup) {
        _pickupController.text = prediction.description;
        context.read<LocationBloc>().add(
              SetPickupLocation(
                position: LatLng(
                  details.latitude,
                  details.longitude,
                ),
                address: prediction.description,
              ),
            );
      } else {
        _destinationController.text = prediction.description;
        context.read<LocationBloc>().add(
              SetDestinationLocation(
                position: LatLng(
                  details.latitude,
                  details.longitude,
                ),
                address: prediction.description,
              ),
            );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get location details: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _proceedToBooking() {
    final locationState = context.read<LocationBloc>().state;

    if (locationState is LocationLoaded &&
        locationState.pickupLocation != null &&
        locationState.destinationLocation != null) {
      Navigator.of(context).pushNamed('/ride-booking');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select pickup and destination locations'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConfig.appName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: BlocConsumer<RideBloc, RideState>(
        listener: (context, state) {
          if (state is RideAcceptedState || state is DriverArrivedState || state is RideInProgressState) {
            // Redirect to tracking screen if there's an active ride
            Navigator.of(context).pushReplacementNamed('/ride-tracking');
          }
        },
        builder: (context, rideState) {
          // Check for active ride
          if (rideState is RideLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<LocationBloc, LocationState>(
            builder: (context, locationState) {
              if (locationState is LocationInitial || locationState is LocationLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (locationState is LocationError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_off,
                        color: Colors.red,
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Location Error',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(locationState.message),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LocationBloc>().add(GetCurrentLocation());
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (locationState is LocationLoaded) {
                return Stack(
                  children: [
                    // Map
                    MapWidget(
                      currentLocation: locationState.currentLocation,
                      pickupLocation: locationState.pickupLocation,
                      destinationLocation: locationState.destinationLocation,
                    ),

                    // Search panel
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConfig.cardBorderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              // Pickup field
                              TextFormField(
                                controller: _pickupController,
                                focusNode: _pickupFocusNode,
                                decoration: InputDecoration(
                                  hintText: 'Pickup location',
                                  prefixIcon: Icon(Icons.location_on, color: Colors.green),
                                  suffixIcon: _pickupController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            _pickupController.clear();
                                            context.read<LocationBloc>().add(
                                                  SetPickupLocation(
                                                    position: locationState.currentLocation,
                                                    address: 'Current Location',
                                                  ),
                                                );
                                          },
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onChanged: _searchLocation,
                              ),

                              const SizedBox(height: 12),

                              // Destination field
                              TextFormField(
                                controller: _destinationController,
                                focusNode: _destinationFocusNode,
                                decoration: InputDecoration(
                                  hintText: 'Where to?',
                                  prefixIcon: Icon(Icons.location_on, color: Colors.red),
                                  suffixIcon: _destinationController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            _destinationController.clear();
                                            context.read<LocationBloc>().add(
                                                  SetDestinationLocation(
                                                    position: locationState.currentLocation,
                                                    address: '',
                                                  ),
                                                );
                                          },
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onChanged: _searchLocation,
                              ),

                              const SizedBox(height: 16),

                              // Book ride button
                              ElevatedButton(
                                onPressed: locationState.pickupLocation != null &&
                                        locationState.destinationLocation != null
                                    ? _proceedToBooking
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Book Ride'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Search results
                    if (_isAddressSearch)
                      Positioned(
                        top: 16,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              // Search header
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: _cancelSearch,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        _isSearchingForPickup ? 'Enter pickup location' : 'Enter destination',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Search results
                              Expanded(
                                child: locationState.searchResults.isEmpty
                                    ? Center(
                                        child: Text(
                                          'Search for a location',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    : ListView.separated(
                                        itemCount: locationState.searchResults.length,
                                        separatorBuilder: (context, index) => Divider(),
                                        itemBuilder: (context, index) {
                                          final prediction = locationState.searchResults[index];
                                          return ListTile(
                                            leading: Icon(Icons.location_on),
                                            title: Text(prediction.mainText),
                                            subtitle: Text(prediction.secondaryText),
                                            onTap: () => _selectLocation(prediction),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              }

              return const Center(child: Text('Something went wrong'));
            },
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('User 1'),
          accountEmail: Text("Email"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              'Cole',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConfig.primaryColor,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: AppConfig.primaryColor,
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Ride History'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/ride-history');
          },
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Payment'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/payment');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/profile');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Help & Support'),
          onTap: () {
            Navigator.pop(context);
            // TODO: Navigate to help screen
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            Navigator.pop(context);
            // context.read<AuthBloc>().add(LogoutRequested());
          },
        ),
      ],
    );
  }
}

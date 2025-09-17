import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapWidget extends StatefulWidget {
  final LatLng currentLocation;
  final LatLng? pickupLocation;
  final LatLng? destinationLocation;
  final LatLng? driverLocation;
  final bool showDriverMarker;
  final bool showDirections;
  final bool showUserLocation;
  final double zoom;
  final MapType mapType;
  final VoidCallback? onMapCreated;
  final Function(LatLng)? onTap;

  const MapWidget({
    Key? key,
    required this.currentLocation,
    this.pickupLocation,
    this.destinationLocation,
    this.driverLocation,
    this.showDriverMarker = false,
    this.showDirections = false,
    this.showUserLocation = true,
    this.zoom = 15.0,
    this.mapType = MapType.normal,
    this.onMapCreated,
    this.onTap,
  }) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  @override
  void didUpdateWidget(MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update markers if locations changed
    if (oldWidget.currentLocation != widget.currentLocation ||
        oldWidget.pickupLocation != widget.pickupLocation ||
        oldWidget.destinationLocation != widget.destinationLocation ||
        oldWidget.driverLocation != widget.driverLocation ||
        oldWidget.showDriverMarker != widget.showDriverMarker) {
      _updateMarkers();
    }

    // Update camera position if driver location changed
    if (widget.driverLocation != null && oldWidget.driverLocation != widget.driverLocation) {
      _animateToDriverLocation();
    }
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear();

      // Current user location marker
      if (widget.showUserLocation) {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: widget.currentLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(
              title: 'Your Location',
            ),
          ),
        );
      }

      // Pickup location marker
      if (widget.pickupLocation != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('pickup_location'),
            position: widget.pickupLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: const InfoWindow(
              title: 'Pickup Location',
            ),
          ),
        );
      }

      // Destination location marker
      if (widget.destinationLocation != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('destination_location'),
            position: widget.destinationLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: const InfoWindow(
              title: 'Destination',
            ),
          ),
        );
      }

      // Driver location marker
      if (widget.driverLocation != null && widget.showDriverMarker) {
        _markers.add(
          Marker(
            markerId: const MarkerId('driver_location'),
            position: widget.driverLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            infoWindow: const InfoWindow(
              title: 'Driver',
            ),
            rotation: 0.0, // You can update this with actual bearing
          ),
        );
      }
    });

    // Update polylines if directions should be shown
    if (widget.showDirections) {
      _updateDirections();
    }
  }

  void _updateDirections() {
    // In a real app, you would call Google Directions API here
    // For now, we'll just draw a simple line between pickup and destination
    if (widget.pickupLocation != null && widget.destinationLocation != null) {
      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('pickup_to_destination'),
            points: [widget.pickupLocation!, widget.destinationLocation!],
            color: Colors.blue,
            width: 4,
            patterns: [PatternItem.dash(20), PatternItem.gap(10)],
          ),
        );
      });
    }

    // If driver location is available, show route from driver to pickup
    if (widget.driverLocation != null && widget.pickupLocation != null && widget.showDriverMarker) {
      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('driver_to_pickup'),
            points: [widget.driverLocation!, widget.pickupLocation!],
            color: Colors.orange,
            width: 3,
          ),
        );
      });
    }
  }

  void _animateToDriverLocation() {
    if (_mapController != null && widget.driverLocation != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(widget.driverLocation!),
      );
    }
  }

  void _fitMarkersInView() {
    if (_mapController == null || _markers.isEmpty) return;

    double minLat = _markers.first.position.latitude;
    double maxLat = _markers.first.position.latitude;
    double minLng = _markers.first.position.longitude;
    double maxLng = _markers.first.position.longitude;

    for (Marker marker in _markers) {
      minLat = minLat < marker.position.latitude ? minLat : marker.position.latitude;
      maxLat = maxLat > marker.position.latitude ? maxLat : marker.position.latitude;
      minLng = minLng < marker.position.longitude ? minLng : marker.position.longitude;
      maxLng = maxLng > marker.position.longitude ? maxLng : marker.position.longitude;
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100.0, // padding
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        widget.onMapCreated?.call();

        // Fit all markers in view after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_markers.isNotEmpty) {
            _fitMarkersInView();
          }
        });
      },
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation,
        zoom: widget.zoom,
      ),
      markers: _markers,
      polylines: _polylines,
      mapType: widget.mapType,
      myLocationEnabled: false, // We're showing custom user location marker
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      onTap: widget.onTap,
      trafficEnabled: false,
      buildingsEnabled: true,
      indoorViewEnabled: false,
      compassEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

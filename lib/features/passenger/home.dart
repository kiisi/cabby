import 'dart:math';
import 'dart:typed_data';
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/services/location_service.dart';
import 'package:cabby/core/widgets/app_drawer.dart';
import 'package:cabby/core/widgets/button.dart';
import 'package:cabby/features/passenger/location-appbar.dart/bloc/location_service_bloc.dart';
import 'package:cabby/features/passenger/location-appbar.dart/location_appbar.dart';
import 'package:cabby/features/passenger/passenger-locations/bloc/passenger_locations_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? controller;

  final LocationService _locationService = LocationService();

  late CameraPosition _kGooglePlex;
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target:
          LatLng(_appPreferences.getLatitude(), _appPreferences.getLongitude()),
      zoom: 18,
    );
    super.initState();
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }

  Future<void> _moveToCurrentLocation() async {
    Position position = await _locationService.determinePosition();

    await controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 17),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationServiceBloc, LocationServiceState>(
      builder: (context, state) {
        return Scaffold(
          appBar: LocationAppBar(
            context: context,
            enableLocationAppbar: state.isLocationEnabled == null ||
                state.isLocationEnabled == false,
          ),
          body: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: _onMapCreated,
                gestureRecognizers: //
                    <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Builder(
                  builder: (context) => Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(AppSize.s50),
                    child: IconButton(
                      color: ColorManager.blueLight,
                      constraints:
                          const BoxConstraints(minHeight: 52, minWidth: 52),
                      highlightColor: const Color(0xFFE4E4E4),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu_rounded),
                    ),
                  ),
                ),
              ),
            ],
          ),
          drawer: AppDrawer(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: () {
                _moveToCurrentLocation();
              },
              child: const Icon(Icons.my_location),
            ),
          ),
          bottomSheet: _bottomSheet(),
        );
      },
    );
  }

  Widget _bottomSheet() {
    return BlocBuilder<PassengerLocationsBloc, PassengerLocationsState>(
      builder: (context, state) {
        return BottomSheet(
          enableDrag: false,
          onClosing: () {},
          builder: (BuildContext context) {
            return SizedBox(
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _pickupLocationBox(state),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      _destinationLocationBox(state),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      Button(
                        onPressed: () async {
                          if (state.pickupLocation?.address != null &&
                              state.destinationLocation?.address != null) {
                            await context.router
                                .pushNamed('/passenger-journey');
                          } else {
                            await context.router
                                .pushNamed('/passenger-locations');
                          }
                        },
                        child: const Text(
                          'Find a Cab',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _pickupLocationBox(PassengerLocationsState state) {
    return SizedBox(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Container(
          height: AppSize.s50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.whiteGrey,
            borderRadius: BorderRadius.circular(AppSize.s10),
            border: Border.all(color: ColorManager.blueDark),
          ),
          child: Material(
            type: MaterialType.transparency,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSize.s10),
              onTap: () async {
                await context.router.pushNamed('/passenger-locations');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
                child: Row(
                  children: [
                    SizedBox(
                      width: AppSize.s24,
                      child: UnconstrainedBox(
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border:
                                Border.all(color: ColorManager.blue, width: 5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        state.pickupLocation?.address ?? 'Pickup Location',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: state.pickupLocation?.address == null
                                ? ThemeData.light().hintColor
                                : null),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _destinationLocationBox(PassengerLocationsState state) {
    return SizedBox(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Container(
          height: AppSize.s50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.whiteGrey,
            borderRadius: BorderRadius.circular(AppSize.s10),
            border: Border.all(color: ColorManager.blueDark),
          ),
          child: Material(
            type: MaterialType.transparency,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSize.s10),
              onTap: () async {
                await context.router.pushNamed('/passenger-locations');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
                child: Row(
                  children: [
                    Icon(Icons.search, color: ColorManager.blue, weight: 900),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Flexible(
                      child: Text(
                        state.destinationLocation?.shortAddress ??
                            'Destination Location',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: state.destinationLocation?.address == null
                                ? ThemeData.light().hintColor
                                : null),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

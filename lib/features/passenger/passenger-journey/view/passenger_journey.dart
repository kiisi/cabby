import 'dart:typed_data';
import 'package:cabby/core/common/marker.dart';
import 'package:intl/intl.dart';

import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/loading_status.dart';
import 'package:cabby/core/common/shimmer.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/widgets/button.dart';
import 'package:cabby/domain/models/payment_methods.dart';
import 'package:cabby/features/passenger/location-appbar.dart/bloc/location_service_bloc.dart';
import 'package:cabby/features/passenger/location-appbar.dart/location_appbar.dart';
import 'package:cabby/features/passenger/passenger-locations/bloc/passenger_locations_bloc.dart';
import 'package:cabby/features/passenger/payment/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

@RoutePage()
class PassengerJourneyScreen extends StatefulWidget {
  const PassengerJourneyScreen({super.key});

  @override
  State<PassengerJourneyScreen> createState() => _PassengerJourneyScreenState();
}

class _PassengerJourneyScreenState extends State<PassengerJourneyScreen> {
  GoogleMapController? controller;

  final GlobalKey key = GlobalKey();

  BitmapDescriptor? customMarker;

  final AppPreferences _appPreferences = getIt<AppPreferences>();

  List<Marker> markers = [];

  final PassengerLocationsBloc _passengerLocationsBloc =
      getIt<PassengerLocationsBloc>();

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }

  String getPaymentMethod() {
    return _appPreferences.getPaymentMethod();
  }

  GlobalKey markerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    var state = _passengerLocationsBloc.state;

    List<City> cities = [
      City(
          "Pickup",
          LatLng(
              state.pickupLocation!.latitude, state.pickupLocation!.longitude)),
      City(
          "Destination",
          LatLng(state.destinationLocation!.latitude,
              state.destinationLocation!.longitude)),
    ];

    List<Widget> markerWidgets() {
      return cities.map((c) => _getMarkerWidget(c.name)).toList();
    }

    List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
      List<Marker> markersList = [];
      bitmaps.asMap().forEach((i, bmp) {
        final city = cities[i];
        markersList.add(Marker(
            markerId: MarkerId(city.name),
            position: city.position,
            icon: BitmapDescriptor.fromBytes(bmp)));
      });
      return markersList;
    }

    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PassengerLocationsBloc, PassengerLocationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var startLocationLatitude =
            state.pickupLocation?.latitude ?? _appPreferences.getLatitude();
        var startLocationLongitude =
            state.pickupLocation?.longitude ?? _appPreferences.getLongitude();
        var endLocationLatitude = state.destinationLocation?.latitude ?? 0.0;
        var endLocationLongitude = state.destinationLocation?.longitude ?? 0.0;

        double southWestLat;
        double southWestLong;
        double northEastLat;
        double northEastLong;

        if (startLocationLatitude <= endLocationLatitude) {
          southWestLat = startLocationLatitude;
          northEastLat = endLocationLatitude;
        } else {
          northEastLat = startLocationLatitude;
          southWestLat = endLocationLatitude;
        }

        if (startLocationLongitude <= endLocationLongitude) {
          southWestLong = startLocationLongitude;
          northEastLong = endLocationLongitude;
        } else {
          northEastLong = startLocationLongitude;
          southWestLong = endLocationLongitude;
        }

        controller?.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                northEastLat,
                northEastLong,
              ),
              southwest: LatLng(
                southWestLat,
                southWestLong,
              ),
            ),
            60.0,
          ),
        );
        return BlocBuilder<LocationServiceBloc, LocationServiceState>(
          builder: (locationContext, locationState) {
            return Scaffold(
              appBar: LocationAppBar(
                context: context,
                enableLocationAppbar: locationState.isLocationEnabled == null ||
                    locationState.isLocationEnabled == false,
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    polylines: state.polylineSet,
                    markers: markers.toSet(),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        state.destinationLocation?.latitude ??
                            state.pickupLocation?.latitude ??
                            _appPreferences.getLatitude(),
                        state.destinationLocation?.longitude ??
                            state.pickupLocation?.longitude ??
                            _appPreferences.getLongitude(),
                      ),
                      zoom: 16,
                    ),
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                  ),
                  Positioned(
                    top: 20,
                    left: 15,
                    right: 15,
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: SizedBox(
                        height: 48,
                        width: 200,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.router.maybePop();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                margin: const EdgeInsets.only(
                                    top: 4, bottom: 4, right: 4),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Color(0xfff4f4f6),
                                ),
                                child: Center(
                                  child: Text(
                                    state.destinationLocation?.shortAddress ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.router.popUntilRouteWithPath('/home');
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomSheet: _confirmationBottomSheet(state),
            );
          },
        );
      },
    );
  }

  Widget _confirmationBottomSheet(PassengerLocationsState state) {
    NumberFormat formatter = NumberFormat("#,##0", "en_US");

    // Formatting the amount
    String estimatedFare = state.estimatedFareValue != null
        ? formatter.format(state.estimatedFareValue)
        : '';
    String currency = state.estimatedFareCurrency ?? '';

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
                  const SizedBox(
                    height: AppSize.s6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 36),
                    child: Text(
                      state.destinationLocation?.shortAddress ?? '',
                      style: const TextStyle(
                        fontSize: AppSize.s20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Oceanwide',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s6,
                  ),
                  state.estimatedFareLoadingStatus == LoadingStatus.loading
                      ? const ShimmerLoadingAnimation(
                          height: 14,
                        )
                      : RichText(
                          text: TextSpan(
                            text: 'Cabby  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: AppSize.s12,
                                fontWeight: FontWeight.w300),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${currency.toUpperCase()} $estimatedFare',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  _paymentMethod(),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  state.extraLoadingStatus == LoadingStatus.loading
                      ? const ShimmerLoadingAnimation()
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffE3F5FF),
                          ),
                          child: Row(children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xff4783C2),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Travel time: ~${state.locationDirection?.durationText ?? ""}.',
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Oceanwide',
                              ),
                            ),
                          ]),
                        ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Button(
                    onPressed: () {},
                    borderRadius: AppSize.s100,
                    child: const Text(
                      'Confirm order',
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
  }

  Widget _paymentMethod() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: () async {
            await context.router.pushNamed('/payment');
          },
          child: ListTile(
            tileColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                state.paymentMethod == PaymentMethods.cash
                    ? 'assets/images/dollar.png'
                    : 'assets/images/cabby-cash.png',
                height: AppSize.s24,
                width: AppSize.s24,
              ),
            ),
            title: Text(
              state.paymentMethod == PaymentMethods.cash
                  ? PaymentMethods.cash
                  : PaymentMethods.cabbyCash,
              style: const TextStyle(color: Color(0xFF737479)),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}

Widget _getMarkerWidget(String name) {
  return Container(
    padding: const EdgeInsets.all(5),
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.white,
    ),
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color(0xFF6572FF),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
      ),
    ),
  );
}

// Example of backing data

class City {
  final String name;
  final LatLng position;

  City(this.name, this.position);
}

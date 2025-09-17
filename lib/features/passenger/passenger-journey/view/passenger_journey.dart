import 'dart:typed_data';
import 'package:cabby/core/common/marker.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/widgets/draggable_bottom_sheet.dart';
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
import 'package:colorful_progress_indicators/colorful_progress_indicators.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

@RoutePage()
class PassengerJourneyScreen extends StatefulWidget {
  const PassengerJourneyScreen({super.key});

  @override
  State<PassengerJourneyScreen> createState() => _PassengerJourneyScreenState();
}

class _PassengerJourneyScreenState extends State<PassengerJourneyScreen>
    with SingleTickerProviderStateMixin {
  GoogleMapController? controller;

  final GlobalKey key = GlobalKey();

  bool isConfirmOrderVisible = true;

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
        NumberFormat formatter = NumberFormat("#,##0", "en_US");

        // Formatting the amount
        String estimatedFare = state.estimatedFareValue != null
            ? formatter.format(state.estimatedFareValue)
            : '';
        String currency = state.estimatedFareCurrency ?? '';

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
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                  if (!isConfirmOrderVisible)
                    _draggableBottomSheet(currency, estimatedFare),
                ],
              ),
              bottomSheet: isConfirmOrderVisible
                  ? _confirmationBottomSheet(state)
                  : null,
            );
          },
        );
      },
    );
  }

  Widget _divider() {
    return Container(
      color: const Color(0xFFE9EAEC),
      child: Column(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
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
                    onPressed: () {
                      setState(() {
                        isConfirmOrderVisible = false;
                      });
                    },
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

  Widget _draggableBottomSheet(String currency, String estimatedFare) {
    return DraggableBottomSheet(
      slivers: [
        SliverList.list(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Finding a driver',
                    style: TextStyle(
                      fontSize: AppSize.s24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Oceanwide',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    'Searching for the closest driver for you',
                    style: TextStyle(
                        color: Color(0xFF686869),
                        fontSize: AppSize.s14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    child: ColorfulLinearProgressIndicator(
                      minHeight: 2.5,
                      backgroundColor: Colors.blue[100],
                      colors: [
                        ColorManager.primary,
                      ],
                      duration: const Duration(milliseconds: 500),
                      initialColor: ColorManager.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F5F7),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/safety.svg',
                                  height: 42,
                                  width: 42,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Safety',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F5F7),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/cancel-ride.svg',
                                  height: 42,
                                  width: 42,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Cancel ride',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _divider(),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment method',
                    style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Oceanwide',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Fare',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Euclide',
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF686869),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: 4,
                        width: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFF686869),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Cabby',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Euclide',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.1,
                          color: Color(0xFF686869),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (context, state) {
                      return Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () async {
                            await context.router.pushNamed('/payment');
                          },
                          child: ListTile(
                            tileColor: Colors.transparent,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 0),
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
                              style: const TextStyle(
                                color: Color(0xFF737479),
                                fontFamily: 'Euclide',
                                letterSpacing: 0.1,
                              ),
                            ),
                            trailing: Text(
                              '${currency.toUpperCase()} $estimatedFare',
                              style: const TextStyle(
                                fontFamily: 'Oceanwide',
                                fontSize: 16.0,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            _divider(),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'More',
                    style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Oceanwide',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () async {},
                      child: const ListTile(
                        tileColor: Colors.transparent,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                        leading: Icon(
                          Icons.ios_share_outlined,
                          color: Color(0xFF686869),
                        ),
                        title: Text(
                          'Share ride details',
                          style: TextStyle(
                            fontFamily: 'Euclide',
                            color: Color(0xFF686869),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Color(0xFF686869),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () async {},
                      child: const ListTile(
                        tileColor: Colors.transparent,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                        leading: Icon(
                          Icons.call_outlined,
                          color: Color(0xFF686869),
                        ),
                        title: Text(
                          'Contact driver',
                          style: TextStyle(
                            fontFamily: 'Euclide',
                            color: Color(0xFF686869),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Color(0xFF686869),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () async {},
                      child: const ListTile(
                        tileColor: Colors.transparent,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                        leading: Icon(
                          Icons.block_outlined,
                          color: Color(0xFF686869),
                        ),
                        title: Text(
                          'Cancel ride',
                          style: TextStyle(
                            fontFamily: 'Euclide',
                            color: Color(0xFF686869),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Color(0xFF686869),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
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

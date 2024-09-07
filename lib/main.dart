import 'dart:async';

import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/constants.dart';
import 'package:cabby/core/resources/theme_manager.dart';
import 'package:cabby/core/routes/app_router.dart';
import 'package:cabby/core/services/location_service.dart';
import 'package:cabby/features/auth/authentication/bloc/authentication_bloc.dart';
import 'package:cabby/features/auth/otp-verification/bloc/otp_verification_bloc.dart';
import 'package:cabby/features/auth/welcome-user/bloc/welcome_user_bloc.dart';
import 'package:cabby/features/passenger/location-appbar.dart/bloc/location_service_bloc.dart';
import 'package:cabby/features/passenger/passenger-locations/bloc/passenger_locations_bloc.dart';
import 'package:cabby/features/passenger/payment/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();

  // Stripe
  Stripe.publishableKey = Constant.stripePublishableKey;

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
    initializeMapRenderer();
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Background color of the status bar
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initAppModule();

  runApp(const MyApp());
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

/// Initializes map renderer to the `latest` renderer type for Android platform.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  final LocationService _locationService = LocationService();

  final LocationServiceBloc _locationServiceBloc = getIt<LocationServiceBloc>();

  final PassengerLocationsBloc _passengerLocationsBloc =
      getIt<PassengerLocationsBloc>();

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() async {
    Position position = await _locationService.determinePosition();
    await _appPreferences.setLatitude(position.latitude);
    await _appPreferences.setLongitude(position.longitude);

    _passengerLocationsBloc.add(
      PassengerLocationsPickup(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );

    final positionStream = _geolocatorPlatform.getPositionStream(
      locationSettings:
          const LocationSettings(accuracy: LocationAccuracy.bestForNavigation),
    );
    positionStream.handleError((error) {
      // print("=============GEOLOCATOR ERROR=======");
      _locationServiceBloc.add(LocationServiceDisabled());
    }).listen((position) {
      // print("========GEOLOCATOR SUCCESS==========");
      _locationServiceBloc.add(LocationServiceEnabled(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationServiceBloc>(
          create: (BuildContext context) => getIt<LocationServiceBloc>(),
        ),
        BlocProvider<PassengerLocationsBloc>(
          create: (BuildContext context) => getIt<PassengerLocationsBloc>(),
        ),
        BlocProvider<PaymentBloc>(
          create: (BuildContext context) => getIt<PaymentBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider<OtpVerificationBloc>(
          create: (BuildContext context) => getIt<OtpVerificationBloc>(),
        ),
        BlocProvider<WelcomeUserBloc>(
          create: (BuildContext context) => getIt<WelcomeUserBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        theme: getApplicationTheme(),
      ),
    );
  }
}

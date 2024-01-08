import 'dart:async';

import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/theme_manager.dart';
import 'package:cabby/core/routes/app_router.dart';
import 'package:cabby/core/services/location_service.dart';
import 'package:cabby/features/passenger/location-appbar.dart/bloc/location_service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.blue, // Background color of the status bar
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initAppModule();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  final LocationService _locationService = LocationService();
  final LocationServiceBloc _locationServiceBloc = getIt<LocationServiceBloc>();
  late StreamSubscription<Position> _locationStreamSubscription;

  final LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() async {
    // Working Perfectly
    try {
      Position position = await _locationService.determinePosition();
      print("=======Location Success==========");
      print(position.latitude);
      print(position.longitude);
      _locationServiceBloc.add(LocationServiceEnabled());
    } catch (error) {
      print("========Location Error==========");
      _locationServiceBloc.add(LocationServiceDisabled());
      print(error);
    }

    Geolocator.getPositionStream(
      locationSettings: _locationSettings,
    ).listen((Position position) {
      print("=============Success==============");
      print(
          '${position.latitude.toString()}, ${position.longitude.toString()}');
      _locationServiceBloc.add(LocationServiceEnabled());
    }).onError((error) {
      print("=============Error==============");
      print(error);
      _locationServiceBloc.add(LocationServiceDisabled());
    });

    // Geolocator.getPositionStream(
    //   locationSettings: _locationSettings,
    // )
    //     .asyncExpand((Position? position) async* {
    //       try {
    //         _locationServiceBloc.add(LocationServiceEnabled());
    //         print(position == null
    //             ? 'Unknown'
    //             : '${position.latitude.toString()}, ${position.longitude.toString()}');
    //       } catch (error) {
    //         print("=============Error==============");
    //         print(error);
    //         _locationServiceBloc.add(LocationServiceDisabled());
    //       }
    //     })
    //     .listen((_) {}) // Listen to ensure the stream is active
    //     .onError((error) {
    //       // Handle errors if any occur during asyncExpand
    //       print("Error during asyncExpand: $error");
    //     });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocationServiceBloc>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        theme: getApplicationTheme(),
      ),
    );
  }
}

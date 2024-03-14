// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:cabby/features/auth/authentication/authentication.dart' as _i1;
import 'package:cabby/features/auth/otp-verification/otp_verification.dart'
    as _i5;
import 'package:cabby/features/auth/welcome-user/welcome_user.dart' as _i7;
import 'package:cabby/features/loading_indicator.dart' as _i3;
import 'package:cabby/features/onboarding/onboarding.dart' as _i4;
import 'package:cabby/features/passenger/home.dart' as _i2;
import 'package:cabby/features/passenger/passenger-locations/passenger_locations.dart'
    as _i6;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    LoadingIndicatorRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoadingIndicatorScreen(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.OnBoardingScreen(),
      );
    },
    OtpVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<OtpVerificationRouteArgs>(
          orElse: () => const OtpVerificationRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.OtpVerificationScreen(
          key: args.key,
          countryCode: args.countryCode,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    PassengerLocationsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PassengerLocationsScreen(),
      );
    },
    WelcomeUserRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeUserRouteArgs>(
          orElse: () => const WelcomeUserRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.WelcomeUserScreen(
          key: args.key,
          countryCode: args.countryCode,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationScreen]
class AuthenticationRoute extends _i8.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoadingIndicatorScreen]
class LoadingIndicatorRoute extends _i8.PageRouteInfo<void> {
  const LoadingIndicatorRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoadingIndicatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingIndicatorRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OnBoardingScreen]
class OnBoardingRoute extends _i8.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i8.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.OtpVerificationScreen]
class OtpVerificationRoute extends _i8.PageRouteInfo<OtpVerificationRouteArgs> {
  OtpVerificationRoute({
    _i9.Key? key,
    String? countryCode,
    String? phoneNumber,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          OtpVerificationRoute.name,
          args: OtpVerificationRouteArgs(
            key: key,
            countryCode: countryCode,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpVerificationRoute';

  static const _i8.PageInfo<OtpVerificationRouteArgs> page =
      _i8.PageInfo<OtpVerificationRouteArgs>(name);
}

class OtpVerificationRouteArgs {
  const OtpVerificationRouteArgs({
    this.key,
    this.countryCode,
    this.phoneNumber,
  });

  final _i9.Key? key;

  final String? countryCode;

  final String? phoneNumber;

  @override
  String toString() {
    return 'OtpVerificationRouteArgs{key: $key, countryCode: $countryCode, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i6.PassengerLocationsScreen]
class PassengerLocationsRoute extends _i8.PageRouteInfo<void> {
  const PassengerLocationsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          PassengerLocationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PassengerLocationsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.WelcomeUserScreen]
class WelcomeUserRoute extends _i8.PageRouteInfo<WelcomeUserRouteArgs> {
  WelcomeUserRoute({
    _i9.Key? key,
    String? countryCode,
    String? phoneNumber,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          WelcomeUserRoute.name,
          args: WelcomeUserRouteArgs(
            key: key,
            countryCode: countryCode,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'WelcomeUserRoute';

  static const _i8.PageInfo<WelcomeUserRouteArgs> page =
      _i8.PageInfo<WelcomeUserRouteArgs>(name);
}

class WelcomeUserRouteArgs {
  const WelcomeUserRouteArgs({
    this.key,
    this.countryCode,
    this.phoneNumber,
  });

  final _i9.Key? key;

  final String? countryCode;

  final String? phoneNumber;

  @override
  String toString() {
    return 'WelcomeUserRouteArgs{key: $key, countryCode: $countryCode, phoneNumber: $phoneNumber}';
  }
}

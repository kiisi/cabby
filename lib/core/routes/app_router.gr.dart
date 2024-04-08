// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:cabby/features/auth/authentication/authentication.dart' as _i1;
import 'package:cabby/features/auth/otp-verification/otp_verification.dart'
    as _i5;
import 'package:cabby/features/auth/welcome-user/welcome_user.dart' as _i9;
import 'package:cabby/features/loading_indicator.dart' as _i3;
import 'package:cabby/features/onboarding/onboarding.dart' as _i4;
import 'package:cabby/features/passenger/home.dart' as _i2;
import 'package:cabby/features/passenger/passenger-journey/view/passenger_journey.dart'
    as _i6;
import 'package:cabby/features/passenger/passenger-locations/view/passenger_locations.dart'
    as _i7;
import 'package:cabby/features/passenger/payment/view/payment.dart' as _i8;
import 'package:flutter/material.dart' as _i11;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    LoadingIndicatorRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoadingIndicatorScreen(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.OnBoardingScreen(),
      );
    },
    OtpVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<OtpVerificationRouteArgs>(
          orElse: () => const OtpVerificationRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.OtpVerificationScreen(
          key: args.key,
          countryCode: args.countryCode,
          phoneNumber: args.phoneNumber,
          email: args.email,
        ),
      );
    },
    PassengerJourneyRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PassengerJourneyScreen(),
      );
    },
    PassengerLocationsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PassengerLocationsScreen(),
      );
    },
    PaymentRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PaymentScreen(),
      );
    },
    WelcomeUserRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeUserRouteArgs>(
          orElse: () => const WelcomeUserRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.WelcomeUserScreen(
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
class AuthenticationRoute extends _i10.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoadingIndicatorScreen]
class LoadingIndicatorRoute extends _i10.PageRouteInfo<void> {
  const LoadingIndicatorRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoadingIndicatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingIndicatorRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OnBoardingScreen]
class OnBoardingRoute extends _i10.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i10.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.OtpVerificationScreen]
class OtpVerificationRoute
    extends _i10.PageRouteInfo<OtpVerificationRouteArgs> {
  OtpVerificationRoute({
    _i11.Key? key,
    String? countryCode,
    String? phoneNumber,
    String? email,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          OtpVerificationRoute.name,
          args: OtpVerificationRouteArgs(
            key: key,
            countryCode: countryCode,
            phoneNumber: phoneNumber,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpVerificationRoute';

  static const _i10.PageInfo<OtpVerificationRouteArgs> page =
      _i10.PageInfo<OtpVerificationRouteArgs>(name);
}

class OtpVerificationRouteArgs {
  const OtpVerificationRouteArgs({
    this.key,
    this.countryCode,
    this.phoneNumber,
    this.email,
  });

  final _i11.Key? key;

  final String? countryCode;

  final String? phoneNumber;

  final String? email;

  @override
  String toString() {
    return 'OtpVerificationRouteArgs{key: $key, countryCode: $countryCode, phoneNumber: $phoneNumber, email: $email}';
  }
}

/// generated route for
/// [_i6.PassengerJourneyScreen]
class PassengerJourneyRoute extends _i10.PageRouteInfo<void> {
  const PassengerJourneyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PassengerJourneyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PassengerJourneyRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PassengerLocationsScreen]
class PassengerLocationsRoute extends _i10.PageRouteInfo<void> {
  const PassengerLocationsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PassengerLocationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PassengerLocationsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaymentScreen]
class PaymentRoute extends _i10.PageRouteInfo<void> {
  const PaymentRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.WelcomeUserScreen]
class WelcomeUserRoute extends _i10.PageRouteInfo<WelcomeUserRouteArgs> {
  WelcomeUserRoute({
    _i11.Key? key,
    String? countryCode,
    String? phoneNumber,
    List<_i10.PageRouteInfo>? children,
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

  static const _i10.PageInfo<WelcomeUserRouteArgs> page =
      _i10.PageInfo<WelcomeUserRouteArgs>(name);
}

class WelcomeUserRouteArgs {
  const WelcomeUserRouteArgs({
    this.key,
    this.countryCode,
    this.phoneNumber,
  });

  final _i11.Key? key;

  final String? countryCode;

  final String? phoneNumber;

  @override
  String toString() {
    return 'WelcomeUserRouteArgs{key: $key, countryCode: $countryCode, phoneNumber: $phoneNumber}';
  }
}

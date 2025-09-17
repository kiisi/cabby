// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:cabby/features/auth/authentication/authentication.dart' as _i1;
import 'package:cabby/features/auth/otp-verification/otp_verification.dart'
    as _i6;
import 'package:cabby/features/auth/welcome-user/welcome_user.dart' as _i12;
import 'package:cabby/features/homes.dart' as _i3;
import 'package:cabby/features/loading_indicator.dart' as _i4;
import 'package:cabby/features/onboarding/onboarding.dart' as _i5;
import 'package:cabby/features/passenger/home.dart' as _i2;
import 'package:cabby/features/passenger/passenger-journey/view/passenger_journey.dart'
    as _i7;
import 'package:cabby/features/passenger/passenger-locations/view/passenger_locations.dart'
    as _i8;
import 'package:cabby/features/passenger/payment/view/payment.dart' as _i9;
import 'package:cabby/features/profile/view/profile.dart' as _i10;
import 'package:cabby/features/ride_booking.dart' as _i11;
import 'package:flutter/material.dart' as _i14;

/// generated route for
/// [_i1.AuthenticationScreen]
class AuthenticationRoute extends _i13.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthenticationScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.HomesScreen]
class HomesRoute extends _i13.PageRouteInfo<void> {
  const HomesRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomesRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomesRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomesScreen();
    },
  );
}

/// generated route for
/// [_i4.LoadingIndicatorScreen]
class LoadingIndicatorRoute extends _i13.PageRouteInfo<void> {
  const LoadingIndicatorRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoadingIndicatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingIndicatorRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoadingIndicatorScreen();
    },
  );
}

/// generated route for
/// [_i5.OnBoardingScreen]
class OnBoardingRoute extends _i13.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.OnBoardingScreen();
    },
  );
}

/// generated route for
/// [_i6.OtpVerificationScreen]
class OtpVerificationRoute
    extends _i13.PageRouteInfo<OtpVerificationRouteArgs> {
  OtpVerificationRoute({
    _i14.Key? key,
    String? countryCode,
    String? phoneNumber,
    String? email,
    List<_i13.PageRouteInfo>? children,
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

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpVerificationRouteArgs>(
          orElse: () => const OtpVerificationRouteArgs());
      return _i6.OtpVerificationScreen(
        key: args.key,
        countryCode: args.countryCode,
        phoneNumber: args.phoneNumber,
        email: args.email,
      );
    },
  );
}

class OtpVerificationRouteArgs {
  const OtpVerificationRouteArgs({
    this.key,
    this.countryCode,
    this.phoneNumber,
    this.email,
  });

  final _i14.Key? key;

  final String? countryCode;

  final String? phoneNumber;

  final String? email;

  @override
  String toString() {
    return 'OtpVerificationRouteArgs{key: $key, countryCode: $countryCode, phoneNumber: $phoneNumber, email: $email}';
  }
}

/// generated route for
/// [_i7.PassengerJourneyScreen]
class PassengerJourneyRoute extends _i13.PageRouteInfo<void> {
  const PassengerJourneyRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PassengerJourneyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PassengerJourneyRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.PassengerJourneyScreen();
    },
  );
}

/// generated route for
/// [_i8.PassengerLocationsScreen]
class PassengerLocationsRoute extends _i13.PageRouteInfo<void> {
  const PassengerLocationsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PassengerLocationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PassengerLocationsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.PassengerLocationsScreen();
    },
  );
}

/// generated route for
/// [_i9.PaymentScreen]
class PaymentRoute extends _i13.PageRouteInfo<void> {
  const PaymentRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.PaymentScreen();
    },
  );
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ProfileRouteArgs>(orElse: () => const ProfileRouteArgs());
      return _i10.ProfileScreen(key: args.key);
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.RideBookingScreen]
class RideBookingRoute extends _i13.PageRouteInfo<void> {
  const RideBookingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RideBookingRoute.name,
          initialChildren: children,
        );

  static const String name = 'RideBookingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.RideBookingScreen();
    },
  );
}

/// generated route for
/// [_i12.WelcomeUserScreen]
class WelcomeUserRoute extends _i13.PageRouteInfo<void> {
  const WelcomeUserRoute({List<_i13.PageRouteInfo>? children})
      : super(
          WelcomeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeUserRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.WelcomeUserScreen();
    },
  );
}

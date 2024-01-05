// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:cabby/features/auth/authentication/authentication.dart' as _i1;
import 'package:cabby/features/auth/otp-verification/otp_verification.dart'
    as _i4;
import 'package:cabby/features/home/home.dart' as _i2;
import 'package:cabby/features/onboarding/onboarding.dart' as _i3;
import 'package:cabby/features/welcome-user/welcome_user.dart' as _i5;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.OnBoardingScreen(),
      );
    },
    OtpVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<OtpVerificationRouteArgs>(
          orElse: () => const OtpVerificationRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.OtpVerificationScreen(
          key: args.key,
          countryCode: args.countryCode,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    WelcomeUserRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.WelcomeUserScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationScreen]
class AuthenticationRoute extends _i6.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.OnBoardingScreen]
class OnBoardingRoute extends _i6.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i6.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OtpVerificationScreen]
class OtpVerificationRoute extends _i6.PageRouteInfo<OtpVerificationRouteArgs> {
  OtpVerificationRoute({
    _i7.Key? key,
    String? countryCode,
    String? phoneNumber,
    List<_i6.PageRouteInfo>? children,
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

  static const _i6.PageInfo<OtpVerificationRouteArgs> page =
      _i6.PageInfo<OtpVerificationRouteArgs>(name);
}

class OtpVerificationRouteArgs {
  const OtpVerificationRouteArgs({
    this.key,
    this.countryCode,
    this.phoneNumber,
  });

  final _i7.Key? key;

  final String? countryCode;

  final String? phoneNumber;

  @override
  String toString() {
    return 'OtpVerificationRouteArgs{key: $key, countryCode: $countryCode, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i5.WelcomeUserScreen]
class WelcomeUserRoute extends _i6.PageRouteInfo<void> {
  const WelcomeUserRoute({List<_i6.PageRouteInfo>? children})
      : super(
          WelcomeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeUserRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

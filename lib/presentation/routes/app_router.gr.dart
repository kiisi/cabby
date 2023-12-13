// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:cabby/presentation/screens/authentication/authentication.dart'
    as _i1;
import 'package:cabby/presentation/screens/onboarding/onboarding.dart' as _i2;
import 'package:cabby/presentation/screens/otp-verification/otp_verification_screen.dart'
    as _i3;
import 'package:cabby/presentation/screens/welcome-user/welcome_user.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationScreen(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.OnBoardingScreen(),
      );
    },
    OtpVerificationRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.OtpVerificationScreen(),
      );
    },
    WelcomeUserRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.WelcomeUserScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationScreen]
class AuthenticationRoute extends _i5.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.OnBoardingScreen]
class OnBoardingRoute extends _i5.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.OtpVerificationScreen]
class OtpVerificationRoute extends _i5.PageRouteInfo<void> {
  const OtpVerificationRoute({List<_i5.PageRouteInfo>? children})
      : super(
          OtpVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpVerificationRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.WelcomeUserScreen]
class WelcomeUserRoute extends _i5.PageRouteInfo<void> {
  const WelcomeUserRoute({List<_i5.PageRouteInfo>? children})
      : super(
          WelcomeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeUserRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

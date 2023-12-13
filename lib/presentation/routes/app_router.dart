import "package:auto_route/auto_route.dart";

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: '/onboarding', page: OnBoardingRoute.page, initial: true),
        AutoRoute(path: '/authentication', page: AuthenticationRoute.page),
        AutoRoute(path: '/otp-verification', page: OtpVerificationRoute.page),
        AutoRoute(path: '/welcome-user', page: WelcomeUserRoute.page),
      ];
}

import "package:auto_route/auto_route.dart";
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  List<AutoRoute> guardedRoutes(List<AutoRoute> routes, AutoRouteGuard guard) {
    return routes.map((route) => route.copyWith(guards: [guard])).toList();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/loading-indicator',
          page: LoadingIndicatorRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/onboarding',
          page: OnBoardingRoute.page,
          guards: [OnBoardingGuard()],
        ),
        AutoRoute(path: '/authentication', page: AuthenticationRoute.page),
        AutoRoute(path: '/otp-verification', page: OtpVerificationRoute.page),
        AutoRoute(path: '/welcome-user', page: WelcomeUserRoute.page),
        AutoRoute(path: '/home', page: HomeRoute.page),
        AutoRoute(
            path: '/passenger-locations', page: PassengerLocationsRoute.page),
      ];
}

class OnBoardingGuard extends AutoRouteGuard {
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    bool isOnBoardingScreenViewed =
        await _appPreferences.isOnBoardingScreenViewed();

    if (isOnBoardingScreenViewed) {
      router.push(const AuthenticationRoute());
    } else {
      resolver.next(true);
    }
  }
}

import "package:auto_route/auto_route.dart";
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: '/onboarding',
            page: OnBoardingRoute.page,
            initial: true,
            guards: [OnBoardingGuard()]),
        AutoRoute(path: '/authentication', page: AuthenticationRoute.page),
        AutoRoute(path: '/otp-verification', page: OtpVerificationRoute.page),
        AutoRoute(path: '/welcome-user', page: WelcomeUserRoute.page),
        AutoRoute(path: '/home', page: HomeRoute.page),
      ];
}

class OnBoardingGuard extends AutoRouteGuard {
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    bool isOnBoardingScreenViewed =
        await _appPreferences.isOnBoardingScreenViewed();
    print(isOnBoardingScreenViewed);

    if (isOnBoardingScreenViewed) {
      router.push(const AuthenticationRoute());
    } else {
      resolver.next(true);
    }
  }
}

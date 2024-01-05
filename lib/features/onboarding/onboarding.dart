import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/assets_manager.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/strings_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  void initState() {
    super.initState();

    _appPreferences.setOnBoardingScreenViewed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p20, horizontal: AppPadding.p15),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeight.w600,
                            fontSize: AppSize.s28,
                            height: AppSize.s1_5,
                          ),
                          children: [
                            const TextSpan(
                              text: "Move Faster and Safely with ",
                            ),
                            TextSpan(
                              text: "Cabby",
                              style: TextStyle(color: ColorManager.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s80),
                    Image.asset(AssetsManager.onboarding),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: AppSize.s54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                      backgroundColor: ColorManager.blue,
                      foregroundColor: ColorManager.white),
                  onPressed: () {
                    context.router.replaceNamed('/authentication');
                  },
                  child: const Text(
                    AppStrings.getStarted,
                    style: TextStyle(
                        fontSize: AppSize.s18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/routes/app_router.gr.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoadingIndicatorScreen extends StatefulWidget {
  const LoadingIndicatorScreen({super.key});

  @override
  State<LoadingIndicatorScreen> createState() => _LoadingIndicatorScreenState();
}

class _LoadingIndicatorScreenState extends State<LoadingIndicatorScreen> {
  final UserAuthUseCase _userAuthUseCase = getIt<UserAuthUseCase>();
  @override
  void initState() {
    _bind();
    super.initState();
  }

  void _bind() async {
    (await _userAuthUseCase.execute(null)).fold(
      (failure) {
        print("====Failure Error =====");
        print("Failure ${failure.statusCode}");
        print("Failure Message ${failure.message}");
        context.router.replaceAll([const OnBoardingRoute()]);
      },
      (success) => {
        print('Success $success'),
        context.router.replaceAll([HomeRoute()])
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Center(
        child: CupertinoActivityIndicator(
          color: ColorManager.white,
          radius: AppSize.s12,
        ),
      ),
    );
  }
}

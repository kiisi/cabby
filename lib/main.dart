import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.blue, // Background color of the status bar
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initAppModule();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: ColorManager.primary,
        colorScheme: ColorScheme.light(
            primary: ColorManager.primary, secondary: ColorManager.white),
        inputDecorationTheme: InputDecorationTheme(
            focusColor: ColorManager.blueDark,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.blueDark),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.blueDark),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            errorStyle: const TextStyle(fontSize: AppSize.s14)),
        buttonTheme: ButtonThemeData(
          disabledColor: ColorManager.primaryOpacity70,
          buttonColor: ColorManager.primary,
          // splashColor: ColorManager.primaryOpacity70,
        ),
      ),
    );
  }
}

import 'package:cabby/app/di.dart';
import 'package:cabby/presentation/resources/color_manager.dart';
import 'package:cabby/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initAppModule();
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
        ),
      ),
    );
  }
}

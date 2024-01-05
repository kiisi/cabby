import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/data/network/app_api.dart';
import 'package:cabby/data/network/dio_factory.dart';
import 'package:cabby/features/auth/auth.di.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // dio factory
  getIt.registerLazySingleton<DioFactory>(() => DioFactory());

  // app service client
  final dio = await getIt<DioFactory>().getDio();
  getIt.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // SharedPreferences instance
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Register AppPreferences as a singleton
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

  authDependencyInjection();
}

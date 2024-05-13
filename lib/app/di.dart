import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/data/data_source/google_maps_remote_data_source.dart';
import 'package:cabby/data/data_source/passenger_remote_data_source.dart';
import 'package:cabby/data/network/app_api.dart';
import 'package:cabby/data/network/dio_factory.dart';
import 'package:cabby/data/repository/google_maps_repository.dart';
import 'package:cabby/data/repository/passenger_repository.dart';
import 'package:cabby/features/auth/auth.di.dart';
import 'package:cabby/features/passenger/location-appbar.dart/bloc/location_service_bloc.dart';
import 'package:cabby/features/passenger/passenger-locations/passenger.di.dart';
import 'package:cabby/features/passenger/payment/payment.di.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // SharedPreferences instance
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Register AppPreferences as a singleton
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

  // dio factory
  getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt()));

  // app service client
  final dio = await getIt<DioFactory>().getDio();
  getIt.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  getIt.registerLazySingleton<LocationServiceBloc>(() => LocationServiceBloc());

  getIt.registerLazySingleton<GoogleMapsServiceClient>(
      () => GoogleMapsServiceClient(dio));

  getIt.registerLazySingleton<GoogleMapsRouteServiceClient>(
      () => GoogleMapsRouteServiceClient(dio));

  getIt.registerLazySingleton<GoogleMapsRemoteDataSource>(
      () => GoogleMapsRemoteDataSourceImpl(getIt(), getIt()));

  getIt.registerLazySingleton<PassengerRemoteDataSource>(
      () => PassengerRemoteDataSourceImpl(getIt()));

  getIt.registerLazySingleton<GoogleMapsRepository>(
      () => GoogleMapsRepositoryImpl(getIt()));

  getIt.registerLazySingleton<PassengerRepository>(
      () => PassengerRepositoryImpl(getIt()));

  // auth dependency injection
  authDependencyInjection();

  // passenger dependency injection
  passengerDependencyInjection();

  // payment dependency injection
  paymentDependencyInjection();
}

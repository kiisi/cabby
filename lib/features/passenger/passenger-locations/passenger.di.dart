import 'package:cabby/app/di.dart';
import 'package:cabby/domain/usecases/google_maps_usecase.dart';
import 'package:cabby/domain/usecases/passenger_usecase.dart';
import 'package:cabby/features/passenger/passenger-locations/bloc/passenger_locations_bloc.dart';

void passengerDependencyInjection() {
  getIt.registerLazySingleton<PassengerLocationsBloc>(
      () => PassengerLocationsBloc());

  getIt.registerLazySingleton<ReverseGeoCodeUseCase>(
      () => ReverseGeoCodeUseCase(getIt()));

  getIt.registerLazySingleton<AutoCompleteSearchUseCase>(
      () => AutoCompleteSearchUseCase(getIt()));

  getIt.registerLazySingleton<PlaceLocationDetailsUseCase>(
      () => PlaceLocationDetailsUseCase(getIt()));

  getIt.registerLazySingleton<PlaceLocationDirectionUseCase>(
      () => PlaceLocationDirectionUseCase(getIt()));

  getIt.registerLazySingleton<PlaceLocationRouteUseCase>(
      () => PlaceLocationRouteUseCase(getIt()));

  getIt.registerLazySingleton<EstimatedFareUseCase>(
      () => EstimatedFareUseCase(getIt()));
}

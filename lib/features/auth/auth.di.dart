import 'package:cabby/app/di.dart';
import 'package:cabby/data/data_source/auth_remote_data_source.dart';
import 'package:cabby/data/repository/auth_repository.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:cabby/features/auth/authentication/bloc/authentication_bloc.dart';

void authDependencyInjection() {
  getIt.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(getIt()));

  getIt.registerLazySingleton<GetStartedUseCase>(
      () => GetStartedUseCase(getIt()));

  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getIt()));

  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getIt()));

  // getIt.registerLazySingleton<OtpVerificationBloc>(
  //     () => OtpVerificationBloc(getIt(), ));

  getIt
      .registerLazySingleton<OtpVerifyUseCase>(() => OtpVerifyUseCase(getIt()));
}

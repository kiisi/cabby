import 'package:cabby/presentation/screens/authentication/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initAppModule() {
  // Register the AuthenticationBloc as a singleton
  getIt.registerLazySingleton(() => AuthenticationBloc());
}

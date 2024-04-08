import 'package:cabby/app/di.dart';
import 'package:cabby/features/passenger/payment/bloc/payment_bloc.dart';

void paymentDependencyInjection() {
  getIt.registerLazySingleton<PaymentBloc>(() => PaymentBloc());
}

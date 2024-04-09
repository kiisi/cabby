import 'package:bloc/bloc.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/domain/models/payment_methods.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  static final AppPreferences _appPreferences = getIt<AppPreferences>();

  PaymentBloc()
      : super(PaymentState(paymentMethod: _appPreferences.getPaymentMethod())) {
    on<PaymentEvent>((event, emit) {
      if (event is CashPaymentEvent) {
        emit(state.copyWith(paymentMethod: PaymentMethods.cash));
        _appPreferences.setPaymentMethod(PaymentMethods.cash);
      } else if (event is CabbyCashPaymentEvent) {
        emit(state.copyWith(paymentMethod: PaymentMethods.cabbyCash));
        _appPreferences.setPaymentMethod(PaymentMethods.cabbyCash);
      }
    });
  }
}

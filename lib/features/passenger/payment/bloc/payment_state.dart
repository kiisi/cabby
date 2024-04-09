part of 'payment_bloc.dart';

class PaymentState {
  String? paymentMethod;

  PaymentState({this.paymentMethod});

  PaymentState copyWith({String? paymentMethod}) {
    return PaymentState(paymentMethod: paymentMethod ?? this.paymentMethod);
  }
}

part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class CashPaymentEvent extends PaymentEvent {}

class CabbyCashPaymentEvent extends PaymentEvent {}

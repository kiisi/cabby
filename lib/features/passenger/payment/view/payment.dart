import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/domain/models/payment_methods.dart';
import 'package:cabby/features/passenger/payment/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentBloc _paymentBloc = getIt<PaymentBloc>();

  Widget? cashTrailingIcon(PaymentState state) =>
      state.paymentMethod == PaymentMethods.cash
          ? const Icon(Icons.check, color: Color(0xFF737479), size: 18)
          : null;

  Widget? cabbyCashtrailingIcon(PaymentState state) =>
      state.paymentMethod == PaymentMethods.cabbyCash
          ? const Icon(Icons.check, color: Color(0xFF737479), size: 18)
          : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _cabbyCash(),
            _divider(),
            _paymentInfo(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      color: const Color(0xFFE9EAEC),
      child: Column(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cabbyCash() {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Cabby Cash',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff797979),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Image.asset(
              'assets/images/cabby-cash.png',
              height: AppSize.s24,
              width: AppSize.s24,
            ),
            title: const Text(
              PaymentMethods.cabbyCash,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Ubermove',
              ),
            ),
            subtitle: const Text(
              'NGN 0.00',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentInfo() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return SizedBox(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5, left: 22, right: 22),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff797979),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              InkWell(
                onTap: () {
                  _paymentBloc.add(CashPaymentEvent());
                },
                child: ListTile(
                  tileColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                  leading: Image.asset(
                    'assets/images/dollar.png',
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                  title: const Text(
                    "Cash",
                    style: TextStyle(color: Color(0xFF737479)),
                  ),
                  trailing: cashTrailingIcon(state),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  _paymentBloc.add(CabbyCashPaymentEvent());
                },
                child: ListTile(
                  tileColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/images/cabby-cash.png',
                      height: AppSize.s24,
                      width: AppSize.s24,
                    ),
                  ),
                  title: const Text(
                    "Cabby cash",
                    style: TextStyle(color: Color(0xFF737479)),
                  ),
                  trailing: cabbyCashtrailingIcon(state),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {},
                child: ListTile(
                  tileColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/images/stripe-logo.png',
                      height: AppSize.s24,
                      width: AppSize.s24,
                    ),
                  ),
                  title: const Text(
                    "Top up Cabby cash via Stripe",
                    style: TextStyle(color: Color(0xFF737479)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

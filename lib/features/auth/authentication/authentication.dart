import 'package:auto_route/auto_route.dart';
import 'package:cabby/core/common/custom_flushbar.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/strings_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/routes/app_router.gr.dart';
import 'package:cabby/core/widgets/button.dart';
import 'package:cabby/features/auth/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p15,
              right: AppPadding.p15,
              bottom: AppPadding.p20,
              top: AppSize.s160,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      _title(),
                      _subtitle(),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  _emailInput(),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  _processButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      AppStrings.authenticationTitle,
      style: TextStyle(
        color: ColorManager.white,
        fontSize: AppSize.s24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _subtitle() {
    return Text(
      AppStrings.authenticationSubTitle,
      style: TextStyle(
        color: ColorManager.whiteSmoke,
        fontSize: AppSize.s15,
      ),
    );
  }

  Widget _emailInput() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return TextFormField(
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationSetEmail(email: value));
          },
          decoration: InputDecoration(
            errorText: state.emailErrorText,
            hintText: "Email address",
            hintStyle: TextStyle(
                color: ColorManager.blueDark, fontWeight: FontWeight.w300),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: ColorManager.blueDark,
            ),
            fillColor: ColorManager.blackDark,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
                vertical: AppSize.s11_3, horizontal: AppSize.s12),
          ),
          cursorColor: ColorManager.white,
          style: TextStyle(
            color: ColorManager.white,
            fontSize: AppSize.s16,
          ),
        );
      },
    );
  }

  Widget _processButton() {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Button(
            loading: state.formStatus is FormSubmitting,
            onPressed: state.formStatus is FormSubmitting || !state.isFormValid
                ? null
                : () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationSubmission());
                  },
            child: const Text(
              AppStrings.submit,
              style:
                  TextStyle(fontSize: AppSize.s16, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess) {
          context.router.push(OtpVerificationRoute(
            email: state.email,
          ));
        } else if (state.formStatus is FormSubmissionFailed) {
          FormSubmissionFailed errorData =
              (state.formStatus as FormSubmissionFailed);
          CustomFlushbar.showErrorFlushBar(
              context: context, message: errorData.message);
        }
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/custom_snackbar.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/strings_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/routes/app_router.gr.dart';
import 'package:cabby/core/widgets/button.dart';
import 'package:cabby/data/responses/responses.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:cabby/features/auth/otp-verification/bloc/otp_verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

@RoutePage()
class OtpVerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  const OtpVerificationScreen({super.key, this.countryCode, this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String signature = "{{ app signature }}";

  AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationBloc(
        getIt<OtpVerifyUseCase>(),
        countryCode: widget.countryCode ?? '',
        phoneNumber: widget.phoneNumber ?? '',
      ),
      child: Scaffold(
        backgroundColor: ColorManager.black,
        appBar: AppBar(
          backgroundColor: ColorManager.black,
          leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(Icons.arrow_back, color: ColorManager.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            right: AppSize.s15,
            left: AppSize.s15,
            top: AppSize.s50,
            bottom: AppSize.s20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _title(),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  _subTitle(),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  _otpInputField(),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: ColorManager.whiteSmoke,
                          fontSize: AppSize.s16),
                      children: [
                        const TextSpan(text: "Didn't recieve code? "),
                        TextSpan(
                          text: "Resend Code",
                          style: TextStyle(color: ColorManager.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _processButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Check your Phone',
      style: TextStyle(
        fontSize: AppSize.s24,
        color: ColorManager.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _subTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: ColorManager.whiteSmoke, fontSize: AppSize.s15),
        children: [
          const TextSpan(text: "We sent a 6-digit code to "),
          TextSpan(
            text: widget.phoneNumber,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpInputField() {
    return BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
      builder: (context, state) {
        return SizedBox(
          height: AppSize.s60,
          child: PinFieldAutoFill(
            autoFocus: true,
            cursor: Cursor(
              color: ColorManager.white,
              width: AppSize.s1,
              height: AppSize.s24,
              enabled: true,
            ),
            decoration: BoxLooseDecoration(
              gapSpace: AppSize.s10,
              textStyle: TextStyle(
                  color: ColorManager.white,
                  fontSize: AppSize.s18,
                  fontWeight: FontWeight.w600),
              strokeColorBuilder: FixedColorBuilder(
                ColorManager.whiteSmoke,
              ),
            ),
            currentCode: state.otp,
            onCodeSubmitted: (code) {},
            onCodeChanged: (code) {
              context
                  .read<OtpVerificationBloc>()
                  .add(OtpVerificationSetOtp(otp: code));
              if (state.otp?.length == 5) {
                context
                    .read<OtpVerificationBloc>()
                    .add(OtpVerificationSubmission());
              }
            },
            codeLength: 6,
          ),
        );
      },
    );
  }

  Widget _processButton() {
    return BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess) {
          FormSubmissionSuccess<DataResponse> successData =
              (state.formStatus as FormSubmissionSuccess<DataResponse>);
          _appPreferences.setAccessToken(successData.data?.token);
          CustomSnackbar.showSuccessSnackBar(
              context: context, message: successData.message!);
          context.router.replaceAll([const WelcomeUserRoute()]);
        } else if (state.formStatus is FormSubmissionFailed) {
          print("formsubmission failed");
          FormSubmissionFailed errorData =
              (state.formStatus as FormSubmissionFailed);
          print(errorData);
          CustomSnackbar.showErrorSnackBar(
              context: context, message: errorData.message!);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s54,
          child: Button(
            loading: state.formStatus is FormSubmitting,
            onPressed: state.formStatus is FormSubmitting || !state.isFormValid
                ? null
                : () {
                    context
                        .read<OtpVerificationBloc>()
                        .add(OtpVerificationSubmission());
                  },
            child: const Text(
              AppStrings.process,
              style:
                  TextStyle(fontSize: AppSize.s18, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }
}

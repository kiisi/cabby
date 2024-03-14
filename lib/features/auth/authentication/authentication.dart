import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/custom_snackbar.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/strings_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/routes/app_router.gr.dart';
import 'package:cabby/core/widgets/button.dart';
import 'package:cabby/features/auth/authentication/bloc/authentication_bloc.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  CountryCode? selectedCountry = CountryCode.fromCode('NG');

  final _formKey = GlobalKey<FormState>();

  final countryPicker = FlCountryCodePicker(
    filteredCountries: ["AE", "SD", "AU", "KE", "NG"],
    showDialCode: true,
    showSearchBar: false,
    dialCodeTextStyle: TextStyle(color: ColorManager.whiteSmoke),
    countryTextStyle: TextStyle(color: ColorManager.whiteSmoke),
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Center(
        child: Text(
          AppStrings.selectYourCountry,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppSize.s24,
            color: ColorManager.white,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthenticationBloc>(),
      child: Scaffold(
        backgroundColor: ColorManager.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p15,
                right: AppPadding.p15,
                bottom: AppPadding.p20,
                top: AppSize.s200,
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
                      height: AppSize.s48,
                    ),
                    _phoneNumberInput(),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    _processButton(),
                  ],
                ),
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

  Widget _phoneNumberInput() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return TextFormField(
          autofocus: true,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationSetPhoneNumber(phoneNumber: value));
          },
          decoration: InputDecoration(
            errorText: state.phoneNumberErrorText,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: AppSize.s12),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final code = await countryPicker.showPicker(
                          pickerMaxHeight: 300,
                          backgroundColor: ColorManager.blueLight,
                          context: context,
                        );
                        // Null check
                        if (code != null) {
                          setState(() {
                            selectedCountry = code;
                            context.read<AuthenticationBloc>().add(
                                AuthenticationSetCountryCode(
                                    countryCode: code.dialCode));
                          });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s5),
                        child: Image.asset(
                          selectedCountry!.flagUri,
                          fit: BoxFit.cover,
                          width: AppSize.s30,
                          height: AppSize.s24,
                          alignment: Alignment.center,
                          package: selectedCountry!.flagImagePackage,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s6,
                    ),
                    Text(
                      selectedCountry!.dialCode,
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                  ],
                ),
              ),
            ),
            fillColor: ColorManager.blackDark,
            filled: true,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: AppSize.s11_3, horizontal: AppSize.s12),
          ),
          cursorColor: ColorManager.white,
          style: TextStyle(
            color: ColorManager.white,
            fontSize: AppSize.s16,
            fontWeight: FontWeight.w600,
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
              AppStrings.process,
              style:
                  TextStyle(fontSize: AppSize.s18, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess) {
          FormSubmissionSuccess successData =
              (state.formStatus as FormSubmissionSuccess);
          CustomSnackbar.showSuccessSnackBar(
              context: context, message: successData.message!);
          context.router.push(OtpVerificationRoute(
            phoneNumber: state.phoneNumber,
            countryCode: state.countryCode,
          ));
        } else if (state.formStatus is FormSubmissionFailed) {
          FormSubmissionFailed errorData =
              (state.formStatus as FormSubmissionFailed);
          CustomSnackbar.showErrorSnackBar(
              context: context, message: errorData.message!);
        }
      },
    );
  }
}

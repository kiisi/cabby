import 'package:auto_route/auto_route.dart';
import 'package:cabby/core/common/custom_flushbar.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/strings_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/core/widgets/button.dart';
import 'package:cabby/core/widgets/country_code_phone_number_input.dart';
import 'package:cabby/features/auth/welcome-user/bloc/welcome_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WelcomeUserScreen extends StatefulWidget {
  const WelcomeUserScreen({super.key});

  @override
  State<WelcomeUserScreen> createState() => _WelcomeUserScreenState();
}

class _WelcomeUserScreenState extends State<WelcomeUserScreen> {
  List<String> list = <String>['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppSize.s15,
            left: AppSize.s15,
            top: AppSize.s100,
            bottom: AppSize.s20,
          ),
          child: Column(
            children: [
              _title(),
              const SizedBox(
                height: AppSize.s10,
              ),
              _subTitle(),
              const SizedBox(
                height: AppSize.s40,
              ),
              _firstNameInputField(),
              const SizedBox(
                height: AppSize.s20,
              ),
              _lastNameInputField(),
              const SizedBox(
                height: AppSize.s20,
              ),
              _countryCodePhoneNumberInput(),
              const SizedBox(
                height: AppSize.s20,
              ),
              _genderDropdownMenu(),
              const SizedBox(
                height: AppSize.s30,
              ),
              _processButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _title() {
    return Text(
      'Welcome to Cabby!',
      style: TextStyle(
        fontSize: AppSize.s24,
        color: ColorManager.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _subTitle() {
    return Text(
      "Please enter your details",
      style: TextStyle(
          color: ColorManager.whiteSmoke,
          fontSize: AppSize.s15,
          fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget _firstNameInputField() {
    return BlocBuilder<WelcomeUserBloc, WelcomeUserState>(
      builder: (context, state) {
        return TextField(
          autofocus: true,
          onChanged: (value) {
            context
                .read<WelcomeUserBloc>()
                .add(WelcomeUserSetFirstName(firstName: value));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorManager.blackDark,
            hintStyle: TextStyle(
                color: ColorManager.whiteSmoke, fontWeight: FontWeight.w300),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.blueDark),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            border: InputBorder.none,
            hintText: "First name",
            contentPadding: const EdgeInsets.symmetric(
                vertical: AppSize.s11_3, horizontal: AppSize.s12),
          ),
          cursorColor: ColorManager.white,
          style: TextStyle(
            color: ColorManager.white,
            fontSize: AppSize.s16,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  Widget _lastNameInputField() {
    return BlocBuilder<WelcomeUserBloc, WelcomeUserState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context
                .read<WelcomeUserBloc>()
                .add(WelcomeUserSetLastName(lastName: value));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorManager.blackDark,
            hintStyle: TextStyle(
                color: ColorManager.whiteSmoke, fontWeight: FontWeight.w300),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.blueDark),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            border: InputBorder.none,
            hintText: "Last name",
            contentPadding: const EdgeInsets.symmetric(
                vertical: AppSize.s11_3, horizontal: AppSize.s12),
          ),
          cursorColor: ColorManager.white,
          style: TextStyle(
            color: ColorManager.white,
            fontSize: AppSize.s16,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  Widget _countryCodePhoneNumberInput() {
    return BlocBuilder<WelcomeUserBloc, WelcomeUserState>(
      builder: (context, state) {
        return CountryCodePhoneNumberInput(
          onCountryCodeSelected: (value) {
            context
                .read<WelcomeUserBloc>()
                .add(WelcomeUserSetCountryCode(countryCode: value.dialCode));
          },
          onPhoneNumberChanged: (value) {
            context
                .read<WelcomeUserBloc>()
                .add(WelcomeUserSetPhoneNumber(phoneNumber: value));
          },
        );
      },
    );
  }

  Widget _genderDropdownMenu() {
    return BlocBuilder<WelcomeUserBloc, WelcomeUserState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s50,
          child: DropdownMenu<String>(
            enableSearch: false,
            requestFocusOnTap: true,
            textStyle: TextStyle(color: ColorManager.white),
            expandedInsets: const EdgeInsets.all(0),
            menuStyle: MenuStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(ColorManager.blackDark),
              elevation: const WidgetStatePropertyAll(AppSize.s0),
            ),
            inputDecorationTheme: InputDecorationTheme(
              suffixIconColor: ColorManager.white,
              hintStyle: TextStyle(
                  color: ColorManager.whiteSmoke, fontWeight: FontWeight.w300),
              fillColor: ColorManager.blackDark,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.blueDark),
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSize.s8, horizontal: AppSize.s12),
            ),
            hintText: "Gender",
            onSelected: (String? value) {
              // This is called when the user selects an item.
              context
                  .read<WelcomeUserBloc>()
                  .add(WelcomeUserSetGender(gender: value));
            },
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      ColorManager.whiteSmoke,
                    ),
                  ),
                  value: value,
                  label: value);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _processButton() {
    return BlocConsumer<WelcomeUserBloc, WelcomeUserState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess) {
          context.router.replaceNamed('/home');
        } else if (state.formStatus is FormSubmissionFailed) {
          FormSubmissionFailed errorData =
              (state.formStatus as FormSubmissionFailed);
          CustomFlushbar.showErrorFlushBar(
              context: context, message: errorData.message);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s54,
          child: Button(
            loading: state.formStatus is FormSubmitting,
            onPressed: () {
              context.read<WelcomeUserBloc>().add(WelcomeUserSubmission());
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

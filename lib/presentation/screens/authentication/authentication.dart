import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/presentation/resources/color_manager.dart';
import 'package:cabby/presentation/resources/strings_manager.dart';
import 'package:cabby/presentation/resources/values_manager.dart';
import 'package:cabby/presentation/screens/authentication/bloc/authentication_bloc.dart';
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

  final countryPicker = FlCountryCodePicker(
    filteredCountries: ["AE", "SD", "AU", "KE"],
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
              color: ColorManager.white),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        AppStrings.authenticationTitle,
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: AppSize.s24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        AppStrings.authenticationSubTitle,
                        style: TextStyle(
                          color: ColorManager.whiteSmoke,
                          fontSize: AppSize.s15,
                        ),
                      ),
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
    );
  }

  Widget _phoneNumberInput() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: AppSize.s48,
          decoration: BoxDecoration(
            color: ColorManager.blackDark,
            border: Border.all(color: ColorManager.blueDark),
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      });
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s5),
                    child: Image.asset(
                      selectedCountry!.flagUri,
                      fit: BoxFit.cover,
                      width: AppSize.s30,
                      height: double.infinity,
                      alignment: Alignment.center,
                      package: selectedCountry!.flagImagePackage,
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Text(
                  selectedCountry!.dialCode,
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: AppSize.s16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: AppSize.s8,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppSize.s11_3),
                    ),
                    cursorColor: ColorManager.white,
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: AppSize.s16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _processButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: ColorManager.blueOpacity70,
            disabledForegroundColor: ColorManager.whiteSmoke,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10)),
            backgroundColor: ColorManager.blue,
            foregroundColor: ColorManager.white),
        onPressed: () {
          context.router.pushNamed('/otp-verification');
        },
        child: const Text(
          AppStrings.process,
          style: TextStyle(fontSize: AppSize.s18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:cabby/presentation/resources/color_manager.dart';
import 'package:cabby/presentation/resources/strings_manager.dart';
import 'package:cabby/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomeUserScreen extends StatefulWidget {
  const WelcomeUserScreen({super.key});

  @override
  State<WelcomeUserScreen> createState() => _WelcomeUserScreenState();
}

class _WelcomeUserScreenState extends State<WelcomeUserScreen> {
  String dropdownValue = "";
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
              Text(
                'Welcome to Cabby!',
                style: TextStyle(
                  fontSize: AppSize.s24,
                  color: ColorManager.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Text(
                "Please enter your details",
                style: TextStyle(
                    color: ColorManager.whiteSmoke,
                    fontSize: AppSize.s15,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorManager.blackDark,
                  hintStyle: TextStyle(
                      color: ColorManager.whiteSmoke,
                      fontWeight: FontWeight.w300),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.blueDark),
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
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
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorManager.blackDark,
                  hintStyle: TextStyle(
                      color: ColorManager.whiteSmoke,
                      fontWeight: FontWeight.w300),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.blueDark),
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
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
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              SizedBox(
                width: double.infinity,
                height: AppSize.s50,
                child: DropdownMenu<String>(
                  textStyle: TextStyle(color: ColorManager.white),
                  expandedInsets: const EdgeInsets.all(0),
                  menuStyle: MenuStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(ColorManager.blackDark),
                    elevation: const MaterialStatePropertyAll(AppSize.s0),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    suffixIconColor: ColorManager.white,
                    hintStyle: TextStyle(
                        color: ColorManager.whiteSmoke,
                        fontWeight: FontWeight.w300),
                    fillColor: ColorManager.blackDark,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.blueDark),
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
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
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(ColorManager.whiteSmoke),
                        ),
                        value: value,
                        label: value);
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              SizedBox(
                width: double.infinity,
                height: AppSize.s54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                      backgroundColor: ColorManager.blue,
                      foregroundColor: ColorManager.white),
                  onPressed: () {
                    // context.router.replaceNamed('/authentication');
                  },
                  child: const Text(
                    AppStrings.process,
                    style: TextStyle(
                        fontSize: AppSize.s18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

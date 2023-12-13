import 'package:auto_route/auto_route.dart';
import 'package:cabby/presentation/resources/color_manager.dart';
import 'package:cabby/presentation/resources/strings_manager.dart';
import 'package:cabby/presentation/resources/values_manager.dart';
import 'package:cabby/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

@RoutePage()
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _code = "";
  String signature = "{{ app signature }}";

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
    return Scaffold(
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
                Text(
                  'Check your Phone',
                  style: TextStyle(
                    fontSize: AppSize.s24,
                    color: ColorManager.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        color: ColorManager.whiteSmoke, fontSize: AppSize.s15),
                    children: const [
                      TextSpan(text: "We sent a 6-digit code to "),
                      TextSpan(
                        text: "+918123456789",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                SizedBox(
                  height: AppSize.s60,
                  child: PinFieldAutoFill(
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
                    currentCode: _code,
                    onCodeSubmitted: (code) {},
                    onCodeChanged: (code) {},
                    codeLength: 6,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: ColorManager.whiteSmoke, fontSize: AppSize.s16),
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
                  context.router.replaceAll([const WelcomeUserRoute()]);
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
    );
  }
}

import 'package:cabby/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
    EdgeInsetsGeometry? margin,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 340,
        right: 10,
        left: 10,
      ),
      backgroundColor: Colors.red,
      showCloseIcon: true,
      closeIconColor: ColorManager.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 340,
        right: 10,
        left: 10,
      ),
      backgroundColor: ColorManager.primary,
      showCloseIcon: true,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarningSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: ColorManager.white),
        textAlign: TextAlign.left,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 340,
        right: 10,
        left: 10,
      ),
      backgroundColor: Colors.grey.shade800,
      showCloseIcon: true,
      closeIconColor: ColorManager.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

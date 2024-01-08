import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Button extends ElevatedButton {
  final bool loading;

  Button({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    EdgeInsetsGeometry? padding,
    Widget? child,
    this.loading = false,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight(AppSize.s54),
            disabledBackgroundColor: Colors.blue,
            disabledForegroundColor: ColorManager.whiteSmoke,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: ColorManager.white,
          ),
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: loading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: ColorManager.whiteSmoke,
                  ),
                )
              : child,
        );
}

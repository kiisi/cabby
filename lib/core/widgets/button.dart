import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Button extends ElevatedButton {
  final bool loading;
  final double? borderRadius;

  Button({
    super.key,
    required super.onPressed,
    super.onLongPress,
    ButtonStyle? style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    EdgeInsetsGeometry? padding,
    Widget? child,
    this.loading = false,
    this.borderRadius = AppSize.s8,
  }) : super(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight(AppSize.s48),
            disabledBackgroundColor: Colors.blue,
            disabledForegroundColor: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s10),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: ColorManager.white,
          ),
          child: loading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorManager.white,
                  ),
                )
              : child,
        );
}

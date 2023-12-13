import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#E0678C");
  static Color primaryOpacity70 = HexColor.fromHex("#E0678C28");

  static Color white = HexColor.fromHex("#ffffff");
  static Color whiteSmoke = HexColor.fromHex("#cccccc");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#1c1f24");
  static Color blackDark = HexColor.fromHex("#323943");
  static Color blue = HexColor.fromHex("#064BB5");
  static Color blueOpacity70 = HexColor.fromHex("#064BB528");
  static Color blueDark = HexColor.fromHex("#96b5d3");
  static Color blueLight = HexColor.fromHex("#282e33");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}

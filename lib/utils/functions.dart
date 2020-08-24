import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

Widget generateDefaultIcon({String accountName, double radius = 25}) {
  return CircleAvatar(
    backgroundColor: RandomColor().randomColor(
        colorHue: ColorHue.multiple(
            colorHues: [ColorHue.red, ColorHue.green, ColorHue.blue]),
        colorSaturation: ColorSaturation.mediumSaturation,
        colorBrightness: ColorBrightness.light),
    radius: radius,
    child: Center(
      child: Text(
        accountName[0],
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
      ),
    ),
  );
}

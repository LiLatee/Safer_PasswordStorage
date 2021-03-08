import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:random_color/random_color.dart';
import 'constants.dart' as MyConstants;
import 'functions.dart' as Functions;

Widget generateRandomColorIconAsWidget(
    {String name = '',
    double radius = MyConstants.defaultIconRadius,
    Color color}) {
  color ??= RandomColor().randomColor(
      colorHue: ColorHue.multiple(
          colorHues: [ColorHue.red, ColorHue.green, ColorHue.blue]),
      colorSaturation: ColorSaturation.mediumSaturation,
      colorBrightness: ColorBrightness.light); // TODO zupełnie losowe czy losowo z zdefiniowanych?

  return CircleAvatar(
    backgroundColor: color,
    radius: radius,
    child: Center(
      child: Text(
        name.length > 0 ? name[0].toUpperCase() : 'A',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
      ),
    ),
  );
}

// Widget buildCircleAvatar(
//     {double radius = MyConstants.defaultIconRadius,
//     @required AccountData accountData}) {
//   Widget iconWidget;
//
//   if (MyConstants.availableIconsNames
//       .contains(accountData.accountName.toLowerCase())) {
//     var icon =
//         AssetImage('images/${accountData.accountName.toLowerCase()}.png');
//
//     iconWidget = CircleAvatar(
//       radius: radius,
//       backgroundImage: icon,
//       backgroundColor: Colors.transparent,
//     );
//   }
//
//   iconWidget = Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
//       color: Colors.white,
//       boxShadow: [
//         BoxShadow(blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
//       ],
//     ),
//     child: iconWidget,
//   );
//
//   return iconWidget;
// }

Widget buildCircleAvatarUsingImage(
    {double radius = MyConstants.defaultIconRadius,
    @required Image imageForIcon}) {
  log("circleAvatar-${imageForIcon.width.toString()}", name: "LOL");
  print("circleAvatar-${imageForIcon.width.toString()}");
  print("circleAvatar-${imageForIcon.height.toString()}");
  print("circleAvatar-${imageForIcon.color.toString()}");

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
      color: Colors.white,
      boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
      child: imageForIcon,
    ),
  );
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

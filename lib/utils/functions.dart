import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:random_color/random_color.dart';
import '../constants.dart' as Constants;
import 'functions.dart' as Functions;

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

Widget buildCircleAvatar(
    {double radius = 25.0, @required AccountData accountData}) {
  var icon;
  if (Constants.availableIconsNames
      .contains(accountData.accountName.toLowerCase())) {
    icon = AssetImage('images/${accountData.accountName.toLowerCase()}.png');

    return CircleAvatar(
      radius: radius,
      backgroundImage: icon,
      backgroundColor: Colors.transparent,
    );
  }
  icon = Functions.generateDefaultIcon(
      accountName: accountData.accountName, radius: radius);

  return icon;
}

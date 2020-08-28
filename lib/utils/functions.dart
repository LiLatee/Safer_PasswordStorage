import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:random_color/random_color.dart';
import 'constants.dart' as Constants;
import 'functions.dart' as Functions;

Widget generateRandomColorIcon(
    {String name = '',
    double radius = Constants.defaultIconRadius,
    Color color}) {
  color ??= RandomColor().randomColor(
      colorHue: ColorHue.multiple(
          colorHues: [ColorHue.red, ColorHue.green, ColorHue.blue]),
      colorSaturation: ColorSaturation.mediumSaturation,
      colorBrightness: ColorBrightness.light);

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

Widget buildCircleAvatar(
    {double radius = Constants.defaultIconRadius,
    @required AccountData accountData}) {
  Widget iconWidget;

  if (Constants.availableIconsNames
      .contains(accountData.accountName.toLowerCase())) {
    var icon =
        AssetImage('images/${accountData.accountName.toLowerCase()}.png');

    iconWidget = CircleAvatar(
      radius: radius,
      backgroundImage: icon,
      backgroundColor: Colors.transparent,
    );
  }

  iconWidget = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Constants.defaultIconRadius),
      color: Colors.white,
      boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
      ],
    ),
    child: iconWidget,
  );

  return iconWidget;
}

Widget buildCircleAvatarUsingImage(
    {double radius = Constants.defaultIconRadius,
    @required Image imageForIcon}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Constants.defaultIconRadius),
      color: Colors.white,
      boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(Constants.defaultIconRadius),
      child: imageForIcon,
    ),
  );
}

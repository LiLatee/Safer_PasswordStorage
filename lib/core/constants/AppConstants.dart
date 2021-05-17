import 'package:application_icon/application_icon.dart';
import 'package:flutter/material.dart';

//! SharedPreferences Keys
class SPKeys {
  static const appKey = 'appKey';
  static const biometricOn = 'biometricOn';
  static const theme = 'theme';
  static const String pincode = 'pincode';
  static const String languageCode = 'languageCode';
}

class AppConstants {
  static const String appName = 'Safer';
  static Widget iconWidget =
      Image.asset("lib/core/images/safer_icon.png", width: 70, height: 70);
  static const double defaultPadding = 10.0;
  static const double defaultToScreenEdgePadding = 16.0;
  static const double defaultIconRadius = kMinInteractiveDimension / 2;
  static const double defaultCircularBorderRadius = 25.0;
  static const Color pressedButtonColor = Color(0xFFe94560);
  static const Color dismissColor = Color(0xFFac0d0d);
  static const Duration animationsDuration = Duration(milliseconds: 500);
  static const double heightForOneField = 75.0;
  static const double maxHeightForFields = 300.0;
  static const pinFieldsWidth = 300.0;
  static const Duration splashScreenDuration = Duration(seconds: 1);

  static const List<Color> iconDefaultColors = const [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  static const List<String> defaultIconsNames = [
    'Facebook',
    'Twitter',
    'facebook — kopia',
    'Twitter — kopia',
    'facebook — kopia (2)',
    'facebook — kopia (3)',
    'Twitter — kopia (2)',
    'Twitter — kopia (3)',
    'facebook — kopia (4)',
    'facebook — kopia (5)',
    'Twitter — kopia (4)',
    'Twitter — kopia (5)',
    'facebook — kopia (4)',
    'facebook — kopia (5)',
    'Twitter — kopia (4)',
    'Twitter — kopia (5)',
    'facebook — kopia (6)',
    'facebook — kopia (7)',
    'Twitter — kopia (6)',
    'Twitter — kopia (7)',
    'facebook — kopia (8)',
    'facebook — kopia (9)',
    'Twitter — kopia (8)',
    'Twitter — kopia (9)',
    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  ];

  static final List<Image> defaultIcons = defaultIconsNames
      .map((e) => Image.asset('lib/core/images/${e.toLowerCase()}.png'))
      .toList();

  static final Map<String, Image> defaultIconsMap = Map.fromIterable(
      defaultIconsNames,
      key: (el) => el,
      value: (el) => Image.asset('lib/core/images/${el.toLowerCase()}.png'));
}

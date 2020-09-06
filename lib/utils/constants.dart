import 'package:flutter/material.dart';

const double defaultPadding = 10.0;
const double defaultIconRadius = kMinInteractiveDimension / 2;
const double defaultCircularBorderRadius = 25.0;
const Color pressedButtonColor = Color(0xFFe94560);
const List<String> availableIconsNames = ['facebook', 'twitter'];
const Duration animationsDuration = Duration(milliseconds: 500);
enum ButtonState { pressed, unpressed }
const List<Color> iconDefaultColors = [
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

const List<String> defaultIconsNames = [
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

final List<Image> defaultIcons = defaultIconsNames
    .map((e) => Image.asset('images/${e.toLowerCase()}.png'))
    .toList();

final Map<String, Image> defaultIconsMap = Map.fromIterable(defaultIconsNames,
    key: (el) => el,
    value: (el) => Image.asset('images/${el.toLowerCase()}.png'));

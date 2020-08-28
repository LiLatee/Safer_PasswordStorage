import 'package:flutter/material.dart';

const double defaultPadding = 10.0;
const double defaultIconRadius = 25.0;
const List<String> availableIconsNames = ['facebook', 'twitter'];
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

const List<String> defaultIconsNames = ['Facebook', 'Twitter'];

final List<Image> defaultIcons = defaultIconsNames
    .map((e) => Image.asset('images/${e.toLowerCase()}.png'))
    .toList();

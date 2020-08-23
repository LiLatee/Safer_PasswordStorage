import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(
        fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
    bodyText2:
        TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
  ),
);

ThemeData lightTheme = defaultTheme.copyWith(
  brightness: Brightness.light,
  // primaryColor: Color(0xFFd8b9c3),
  primaryColor: Colors.white,
  // cardColor: Colors.grey,
  cardColor: Colors.white,
  accentColor: Color(0xFF0f3460),
);

ThemeData darkTheme = defaultTheme.copyWith(
  backgroundColor: Colors.black,
  brightness: Brightness.dark,
  primaryColor: Color(0xFF414141),
  accentColor: Colors.blue,
  scaffoldBackgroundColor: Color(0xFF313131),
  unselectedWidgetColor: Colors.red,
  iconTheme: IconThemeData(color: Colors.grey),
  textTheme: TextTheme(
    subtitle1: TextStyle(), // style of account's names as Facebook, Twitter...
    subtitle2: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ), // style of section as Nick, Login/Email...
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ), // style of values for Nick, Login/Email...
  ),
  // ListTile text color
  accentIconTheme: IconThemeData(color: Colors.blue),
);

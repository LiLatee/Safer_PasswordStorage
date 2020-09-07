import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white, // TODO jaki kolor
  brightness: Brightness.light,
  // primaryColor: Color(0xFFd8b9c3),
  primaryColor: Colors.white,
  // cardColor: Colors.grey,
  cardColor: Colors.white,
  secondaryHeaderColor:
      Color(0xFFd6e0f0), // ButtonBar color in AccountDataExpandedPart
  accentColor: Color(0xFF0f3460),
  // buttonColor: Color(0xFF5e6e80),

  fontFamily: 'Roboto',
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ), // button text color

  colorScheme: ColorScheme(
      primary: Colors.white, // FlatButton text color
      primaryVariant: Colors.red,
      secondary: Color(0xFF0f3460), // FloatingButton color
      secondaryVariant: Colors.red,
      surface: Colors.red,
      background: Colors.red,
      error: Colors.red,
      onPrimary: Colors.red,
      onSecondary:
          Colors.white, // FloatingButton child background, e.g. icon color
      onSurface: Color(0xFF0f3460), // TextFormField border color
      onBackground: Colors.red,
      onError: Colors.red,
      brightness: Brightness.light),

  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
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

import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
  fontFamily: 'Georgia',
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
  primaryColor: Color(0xFFd8b9c3),
  accentColor: Color(0xFF827397),
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
      subtitle1: TextStyle(
        color: Colors.white,
      ),
    ),
    // ListTile text color
    accentIconTheme: IconThemeData(color: Colors.blue),


);

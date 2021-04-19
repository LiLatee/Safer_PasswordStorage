import 'package:flutter/material.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = AppTheme.darkTheme;
  ThemeType themeType = ThemeType.Dark;

  toggleTheme() {
    if (themeType == ThemeType.Dark) {
      currentTheme = AppTheme.lightTheme;
      themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (themeType == ThemeType.Light) {
      currentTheme = AppTheme.darkTheme;
      themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}

class AppTheme {
  const AppTheme._();

  // static final defaultTheme = ThemeData(
  //   fontFamily: 'Roboto',
  //   textTheme: TextTheme(
  //     headline1: TextStyle(
  //       fontSize: 24.0,
  //       fontWeight: FontWeight.bold,
  //       color: Colors.black,
  //     ),
  //     headline2: TextStyle(
  //       fontSize: 24.0,
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //     ),
  //   ),
  // );

  static final lightTheme = ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xffd6e0f0),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0f3460),
    ),
    scaffoldBackgroundColor: Colors.white,
    // TODO jaki kolor
    brightness: Brightness.light,
    // primaryColor: Color(0xFFd8b9c3),
    primaryColor: Colors.white,
    // cardColor: Colors.grey,
    cardColor: Colors.white,
    secondaryHeaderColor: Color(0xffd6e0f0),
    // ButtonBar color in AccountDataExpandedPart
    accentColor: Color(0xFF0f3460),
    // buttonColor: Color(0xFF5e6e80),

    fontFamily: 'Roboto',
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    // button text color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Color(0xFF0f3460),
        backgroundColor: Color(0xFFd6e0f0),
      ),
    ),
    // button text col,

    colorScheme: ColorScheme(
        primary: Colors.white,
        // FlatButton text color
        primaryVariant: Colors.red,
        secondary: Color(0xFF0f3460),
        // FloatingButton color
        secondaryVariant: Colors.red,
        surface: Colors.red,
        background: Colors.red,
        error: Colors.red,
        onPrimary: Colors.red,
        onSecondary: Colors.white,
        // FloatingButton child background, e.g. icon color
        onSurface: Color(0xff0f3460),
        // TextFormField border color
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

  static final darkTheme = ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xff542e71),
    ),
    shadowColor: Colors.white70,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0f3460),
    ),
    scaffoldBackgroundColor: Colors.black,
    // TODO jaki kolor
    // brightness: Brightness.light,
    // primaryColor: Color(0xFFd8b9c3),
    primaryColor: Colors.white,
    // cardColor: Colors.grey,
    cardColor: Color(0x393e46),
    secondaryHeaderColor: Color(0xff542e71),
    // ButtonBar color in AccountDataExpandedPart
    accentColor: Colors.white70,
    // buttonColor: Color(0xFF5e6e80),

    fontFamily: 'Roboto',
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    // button text color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Color(0xFF0f3460),
        backgroundColor: Color(0xFFd6e0f0),
      ),
    ),
    // button text col,

    colorScheme: ColorScheme(
        primary: Colors.white,
        // FlatButton text color
        primaryVariant: Colors.red,
        secondary: Color(0xFF0f3460),
        // FloatingButton color
        secondaryVariant: Colors.red,
        surface: Colors.red,
        background: Colors.red,
        error: Colors.red,
        onPrimary: Colors.red,
        onSecondary: Colors.white,
        // FloatingButton child background, e.g. icon color
        onSurface: Color(0xff0f3460),
        // TextFormField border color
        onBackground: Colors.red,
        onError: Colors.red,
        brightness: Brightness.light),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
    ),
  );
}

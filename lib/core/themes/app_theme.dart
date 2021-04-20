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

  static final lightColorScheme = ColorScheme(
    surface: Color(0xffFFFFFF),
    primary: Color(0xff8559da),
    primaryVariant: Color(0xff0c294d), // FlatButton text color
    secondary: Color(0xFFc2185b),
    secondaryVariant: Color(0xFF992e40), // FloatingButton color
    background: Color(0xffFFFFFF),
    error: Color(0xffCF6679),
    onPrimary: Color(0xffFFFFFF),
    onSecondary: Color(0xffFFFFFF),
    onSurface:
        Color(0xff000000), // FloatingButton child background, e.g. icon color
    onBackground: Color(0xff000000), // TextFormField border color
    onError: Color(0xff000000),
    brightness: Brightness.light,
  );

  static final lightTheme = ThemeData.from(colorScheme: lightColorScheme);
  // static final lightTheme = ThemeData(
  //   bottomAppBarTheme: BottomAppBarTheme(
  //     color: Color(0xffd6e0f0),
  //   ),
  //   shadowColor: Colors.grey,
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xFF0f3460),
  //   ),
  //   scaffoldBackgroundColor: Colors.white,
  //   // TODO jaki kolor
  //   brightness: Brightness.light,
  //   // primaryColor: Color(0xFFd8b9c3),
  //   primaryColor: Colors.white,
  //   // cardColor: Colors.grey,
  //   cardColor: Colors.white,
  //   secondaryHeaderColor: Color(0xffd6e0f0),
  //   // ButtonBar color in AccountDataExpandedPart
  //   accentColor: Color(0xFF0f3460),
  //   // buttonColor: Color(0xFF5e6e80),

  //   fontFamily: 'Roboto',
  //   buttonTheme: ButtonThemeData(
  //     textTheme: ButtonTextTheme.primary,
  //   ),
  //   // button text color
  //   textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(
  //       primary: Color(0xFF0f3460),
  //       backgroundColor: Color(0xFFd6e0f0),
  //     ),
  //   ),
  //   // button text col,

  //   colorScheme: ColorScheme(
  //       primary: Colors.white,
  //       // FlatButton text color
  //       primaryVariant: Colors.red,
  //       secondary: Color(0xFF0f3460),
  //       // FloatingButton color
  //       secondaryVariant: Colors.red,
  //       surface: Colors.red,
  //       background: Colors.red,
  //       error: Colors.red,
  //       onPrimary: Colors.red,
  //       onSecondary: Colors.white,
  //       // FloatingButton child background, e.g. icon color
  //       onSurface: Color(0xff0f3460),
  //       // TextFormField border color
  //       onBackground: Colors.red,
  //       onError: Colors.red,
  //       brightness: Brightness.light),

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

  static final darkColorScheme = ColorScheme(
    surface: Color(0xff121212),
    primary: Color(0xff512da8),
    primaryVariant: Color(0xff3700B3), // FlatButton text color
    secondary: Color(0xFF8c0032),
    secondaryVariant: Color(0xFF03DAC6), // FloatingButton color
    background: Color(0xff121212),
    error: Color(0xffCF6679),
    onPrimary: Color(0xffFFFFFF),
    onSecondary: Color(0xffFFFFFF),
    onSurface:
        Color(0xffFFFFFF), // FloatingButton child background, e.g. icon color
    onBackground: Color(0xffFFFFFF), // TextFormField border color
    onError: Color(0xff000000),
    brightness: Brightness.dark,
  );

  static final darkTheme = ThemeData.from(colorScheme: darkColorScheme);

  // static final darkTheme = ThemeData(
  //   colorScheme: darkColorScheme,
  //   applyElevationOverlayColor: true,
  //   brightness: darkColorScheme.brightness,
  // primaryColor: primarySurfaceColor,
  // primaryColorBrightness: ThemeData.estimateBrightnessForColor(primarySurfaceColor),
  // canvasColor: darkColorScheme.background,
  // accentColor: darkColorScheme.secondary,
  // accentColorBrightness:
  //     ThemeData.estimateBrightnessForColor(darkColorScheme.secondary),
  // scaffoldBackgroundColor: darkColorScheme.background,
  // bottomAppBarColor: darkColorScheme.surface,
  // cardColor: darkColorScheme.surface,
  // dividerColor: darkColorScheme.onSurface.withOpacity(0.12),
  // backgroundColor: darkColorScheme.background,
  // dialogBackgroundColor: darkColorScheme.background,
  // errorColor: darkColorScheme.error,
  // textTheme: textTheme,
  // indicatorColor: onPrimarySurfaceColor,
  // );
  // static final darkTheme = ThemeData(
  //   applyElevationOverlayColor: true,
  //   // bottomAppBarTheme: BottomAppBarTheme(
  //   //   color: Color(0xff022c43),
  //   // ),
  //   // shadowColor: Colors.white70,
  //   // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   //   backgroundColor: Color(0xFF0f3460),
  //   // ),
  //   scaffoldBackgroundColor: Color(0xff121212),
  //   // // TODO jaki kolor

  //   // cardColor: Color(0xff424242),
  //   // secondaryHeaderColor: Color(0xff022c43),
  //   // accentColor: Colors.white70,

  //   // iconTheme: IconThemeData(color: Colors.white70),
  //   // fontFamily: 'Roboto',
  //   // buttonTheme: ButtonThemeData(
  //   //   textTheme: ButtonTextTheme.primary,
  //   // ),
  //   // // button text color
  //   // textButtonTheme: TextButtonThemeData(
  //   //   style: TextButton.styleFrom(
  //   //     primary: Color(0xFF0f3460),
  //   //     backgroundColor: Color(0xFFd6e0f0),
  //   //   ),
  //   // ),
  //   // button text col,

  //   colorScheme: ColorScheme(
  //     surface: Color(0xff121212),
  //     primary: Color(0xffBB86FC),
  //     primaryVariant: Color(0xff3700B3), // FlatButton text color
  //     secondary: Color(0xFF03DAC6),
  //     secondaryVariant: Color(0xFF03DAC6), // FloatingButton color
  //     background: Color(0xff121212),
  //     error: Color(0xffCF6679),
  //     onPrimary: Color(0xff000000),
  //     onSecondary: Color(0xff000000),
  //     onSurface:
  //         Color(0xffFFFFFF), // FloatingButton child background, e.g. icon color
  //     onBackground: Color(0xffFFFFFF), // TextFormField border color
  //     onError: Color(0xff000000),
  //     brightness: Brightness.dark,
  //     // surface: Color(0xffFFFFFF),
  //     // primary: Color(0xffFFFFFF),
  //     // primaryVariant: Color(0xffFFFFFF), // FlatButton text color
  //     // secondary: Color(0xffFFFFFF),
  //     // secondaryVariant: Color(0xffFFFFFF), // FloatingButton color
  //     // background: Color(0xffFFFFFF),
  //     // error: Color(0xffFFFFFF),
  //     // onPrimary: Color(0xffFFFFFF),
  //     // onSecondary: Color(0xffFFFFFF),
  //     // onSurface:
  //     //     Color(0xffFFFFFF), // FloatingButton child background, e.g. icon color
  //     // onBackground: Color(0xffFFFFFF), // TextFormField border color
  //     // onError: Color(0xffFFFFFF),
  //     // brightness: Brightness.dark,
  //   ),
  //   // colorScheme: ColorScheme(
  //   //     primary: Colors.white,
  //   //     // FlatButton text color
  //   //     primaryVariant: Colors.red,
  //   //     secondary: Color(0xFF0f3460),
  //   //     // FloatingButton color
  //   //     secondaryVariant: Colors.red,
  //   //     surface: Colors.red,
  //   //     background: Colors.red,
  //   //     error: Colors.red,
  //   //     onPrimary: Colors.red,
  //   //     onSecondary: Colors.white,
  //   //     // FloatingButton child background, e.g. icon color
  //   //     onSurface: Color(0xff0f3460),
  //   //     // TextFormField border color
  //   //     onBackground: Colors.red,
  //   //     onError: Colors.red,
  //   //     brightness: Brightness.light),

  //   // textTheme: TextTheme(
  //   //   headline1: TextStyle(
  //   //     fontSize: 24.0,
  //   //     fontWeight: FontWeight.bold,
  //   //     color: Colors.white70,
  //   //   ),
  //   //   headline2: TextStyle(
  //   //     fontSize: 24.0,
  //   //     fontWeight: FontWeight.bold,
  //   //     color: Colors.white70,
  //   //   ),
  //   //   bodyText1: TextStyle(
  //   //     color: Colors.red,
  //   //   ),
  //   //   bodyText2: TextStyle(
  //   //     color: Colors.white70,
  //   //   ),
  //   // ),
  // );
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = AppTheme.darkTheme;
  ThemeType themeType = ThemeType.Dark;

  // ThemeModel() {
  //   if (SchedulerBinding.instance != null) {
  //     var brightness = SchedulerBinding.instance!.window.platformBrightness;
  //     currentTheme = brightness == Brightness.light ? AppTheme.lightTheme : AppTheme.darkTheme;
  //     themeType = brightness == Brightness.light ? ThemeType.Light : ThemeType.Dark;
  //   }
  // }

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

  static final lightColorScheme = ColorScheme(
    surface: Color(0xffFFFFFF),
    primary: Color(0xff8e24aa),
    primaryVariant: Color(0xff5c007a), // FlatButton text color
    secondary: Color(0xFFd81b60),
    secondaryVariant: Color(0xFFa00037), // FloatingButton color
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

  static final darkColorScheme = ColorScheme(
    surface: Color(0xff121212),
    primary: Color(0xffb39ddb),
    primaryVariant: Color(0xff836fa9), // FlatButton text color
    secondary: Color(0xFFf48fb1),
    secondaryVariant: Color(0xFFbf5f82), // FloatingButton color
    background: Color(0xff121212),
    error: Color(0xffCF6679),
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface:
        Color(0xffFFFFFF), // FloatingButton child background, e.g. icon color
    onBackground: Color(0xffFFFFFF), // TextFormField border color
    onError: Color(0xff000000),
    brightness: Brightness.dark,
  );

  static final darkTheme = ThemeData.from(colorScheme: darkColorScheme);
}

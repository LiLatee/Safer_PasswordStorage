import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// enum ThemeType { Light, Dark, System }

extension ThemeModeExt on ThemeMode {
  String themeName({required BuildContext context}) {
    switch (this) {
      case ThemeMode.light:
        return AppLocalizations.of(context)!.light;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.dark;
      case ThemeMode.system:
        return AppLocalizations.of(context)!.system;
    }
  }
}

class AppTheme {
  const AppTheme._();

  static final _lightColorScheme = ColorScheme(
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

  static final lightTheme = ThemeData.from(
    colorScheme: _lightColorScheme,
  );

  static final _darkColorScheme = ColorScheme(
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

  static final darkTheme = ThemeData.from(colorScheme: _darkColorScheme);
}

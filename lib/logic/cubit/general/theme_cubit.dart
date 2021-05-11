import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/core/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;
  // late ThemeData currentTheme;

  ThemeCubit({required this.prefs}) : super(ThemeInitial()) {
    if (prefs.containsKey(SPKeys.theme)) {
      if (prefs.getString(SPKeys.theme) == ThemeMode.light.toString()) {
        setLightTheme();
      } else if (prefs.getString(SPKeys.theme) == ThemeMode.dark.toString())
        setDarkTheme();
      else if (prefs.getString(SPKeys.theme) == ThemeMode.system.toString())
        setSystemTheme();
    } else {
      setSystemTheme();
    }
  }

  @override
  void onChange(Change<ThemeState> change) {
    super.onChange(change);
    print(
        'ThemeCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  ThemeMode getCurrentThemeMode() {
    if (prefs.containsKey(SPKeys.theme)) {
      if (prefs.getString(SPKeys.theme) == ThemeMode.light.toString())
        return ThemeMode.light;
      else if (prefs.getString(SPKeys.theme) == ThemeMode.dark.toString())
        return ThemeMode.dark;
      else
        return ThemeMode.system;
    } else {
      return ThemeMode.system;
    }
  }

  void setLightTheme() {
    log('ThemeCubit - setLightTheme');
    prefs.setString(SPKeys.theme, ThemeMode.light.toString());
    // currentTheme = AppTheme.lightTheme;
    emit(ThemeLight());
  }

  void setDarkTheme() {
    log('ThemeCubit - setDarkTheme');
    prefs.setString(SPKeys.theme, ThemeMode.dark.toString());
    // currentTheme = AppTheme.darkTheme;
    emit(ThemeDark());
  }

  void setSystemTheme() {
    log('ThemeCubit - setSystemTheme');
    prefs.setString(SPKeys.theme, ThemeMode.system.toString());

    // var brightness = SchedulerBinding.instance!.window.platformBrightness;
    // bool darkModeOn = brightness == Brightness.dark;

    // if (darkModeOn)
    //   currentTheme = AppTheme.darkTheme;
    // else
    //   currentTheme = AppTheme.lightTheme;
    emit(ThemeSystem());
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/core/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;
  ThemeCubit({required this.prefs}) : super(ThemeInitial()) {
    if (prefs.containsKey(SPKeys.theme)) {
      if (prefs.getString(SPKeys.theme) == ThemeType.Light.toString())
        emit(ThemeLight());
      else if (prefs.getString(SPKeys.theme) == ThemeType.Dark.toString())
        emit(ThemeDark());
      else if (prefs.getString(SPKeys.theme) == ThemeType.System.toString())
        emit(ThemeSystem());
    }
  }

  @override
  void onChange(Change<ThemeState> change) {
    super.onChange(change);
    print(
        'ThemeCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  void setLightTheme() {
    log('ThemeCubit - setLightTheme');
    prefs.setString(SPKeys.theme, ThemeType.Light.toString());
    emit(ThemeLight());
  }

  void setDarkTheme() {
    log('ThemeCubit - setDarkTheme');
    prefs.setString(SPKeys.theme, ThemeType.Dark.toString());
    emit(ThemeDark());
  }

  void setSystemTheme() {
    log('ThemeCubit - setSystemTheme');
    prefs.setString(SPKeys.theme, ThemeType.System.toString());
    emit(ThemeSystem());
  }
}

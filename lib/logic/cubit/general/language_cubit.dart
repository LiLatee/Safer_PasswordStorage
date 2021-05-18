import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/AppConstants.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  SharedPreferences prefs;
  LanguageCubit({required this.prefs})
      : super(LanguageState(languageCode: 'system')) {
    if (prefs.containsKey(SPKeys.languageCode)) {
      log('LanguageCubitConstructor: ${prefs.getString(SPKeys.languageCode)!}');
      emit(LanguageState(languageCode: prefs.getString(SPKeys.languageCode)!));
    }
  }

  @override
  void onChange(Change<LanguageState> change) {
    super.onChange(change);
    print(
        "LanguageCubit (${change.currentState.languageCode}) --> (${change.nextState.languageCode}) ");
  }

  void setLanguageCode({required String languageCode}) {
    prefs.setString(SPKeys.languageCode, languageCode);
    emit(LanguageState(languageCode: languageCode));
  }
}

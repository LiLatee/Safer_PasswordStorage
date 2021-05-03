import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final SharedPreferences prefs;

  PreferencesCubit({required this.prefs})
      : super(PreferencesLoaded(keyExists: prefs.containsKey('key')));

  // void checkIfKeyExists() async {
  //   if (prefs.containsKey("key"))
  //     emit(PreferencesKeyExists());
  //   else
  //     emit(PreferencesKeyIsNeeded());
  // }

  void setKey({required String key}) {
    log("w PreferenceCubit");
    prefs.setString('key', key);
    emit(PreferencesLoaded(keyExists: prefs.containsKey('key')));
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_key_state.dart';

class AppKeyCubit extends Cubit<AppKeyState> {
  final SharedPreferences prefs;

  AppKeyCubit({required this.prefs}) : super(AppKeyInitial()) {
    checkIfKeyExists();
  }

  void checkIfKeyExists() async {
    // prefs.remove('key'); // TODO, remove!!! Just for testing purposes.
    log("AppKeyCubit - checkIfKeyExists");
    if (prefs.containsKey("key"))
      emit(AppKeyPresent());
    else
      emit(AppKeyAbsent());
  }

  void setKey({required String key}) {
    log("AppKeyCubit - setKey");
    prefs.setString('key', key);
    emit(AppKeyPresent());
  }
}

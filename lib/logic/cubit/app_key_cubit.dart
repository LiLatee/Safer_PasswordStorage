import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/data/models/app_secret_key_entity.dart';
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
    if (prefs.containsKey(SPKeys.appKey)) {
      AppSecretKeyEntity(key: prefs.getString(SPKeys.appKey)!);
      emit(AppKeyPresent());
    } else
      emit(AppKeyAbsent());
  }

  void generateKey() {
    log("AppKeyCubit - setKey");
    Key key = Key.fromSecureRandom(32);
    prefs.setString(SPKeys.appKey, key.base64);
    AppSecretKeyEntity(key: key.base64);
    emit(AppKeyPresent());
  }

  String getKey() => prefs.getString(SPKeys.appKey)!;
}

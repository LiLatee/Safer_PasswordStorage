import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/AppConstants.dart';
import '../../../data/entities/app_secret_key_entity.dart';

part 'app_key_state.dart';

class AppKeyCubit extends Cubit<AppKeyState> {
  final SharedPreferences prefs;

  AppKeyCubit({required this.prefs}) : super(AppKeyInitial()) {
    log("AppKeyCubit");
    if (!checkIfKeyExists()) {
      generateKey();
      emit(AppKeyPresent());
    }
  }

  bool checkIfKeyExists() {
    log("AppKeyCubit - checkIfKeyExists");
    if (prefs.containsKey(SPKeys.appKey)) {
      AppSecretKeyEntity(key: prefs.getString(SPKeys.appKey)!);
      emit(AppKeyPresent());
      return true;
    } else {
      emit(AppKeyAbsent());
      return false;
    }
  }

  void generateKey() {
    log("AppKeyCubit - setKey");
    Key key = Key.fromSecureRandom(32);
    prefs.setString(SPKeys.appKey, key.base64);
    AppSecretKeyEntity(key: key.base64);
    emit(AppKeyPresent());
  }

  String getKey() => prefs.getString(SPKeys.appKey)!;

  void setKey({required String key}) {
    prefs.setString(SPKeys.appKey, key);
  }
}

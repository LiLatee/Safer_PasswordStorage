import 'dart:developer';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@entity
class AppSecretKeyEntity {
  @ignore
  static final AppSecretKeyEntity _instance = AppSecretKeyEntity._internal();

  @primaryKey
  late String key;

  factory AppSecretKeyEntity({String? key}) {
    if (key != null) _instance.key = key;

    return _instance;
  }

  AppSecretKeyEntity._internal();

  static void setKey({required String key}) {
    _instance.key = key;
  }
}

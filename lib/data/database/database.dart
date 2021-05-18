import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:floor/floor.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_simple_password_storage_clean/data/entities/app_secret_key_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../entities/account_data_entity.dart';
import '../entities/field_data_entity.dart';
import 'account_data_dao.dart';
import 'app_secret_key_dao.dart';
import 'field_data_dao.dart';

part 'database.g.dart';

@Database(
    version: 1,
    entities: [AccountDataEntity, FieldDataEntity, AppSecretKeyEntity])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;
  FieldDataDao get fieldDao;
  AppSecretKeyDao get appSecretKeyDao;

  sqflite.DatabaseExecutor getDatabaseObject() => this.database;
}

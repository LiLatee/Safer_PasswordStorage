import 'dart:async';
import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';
import 'account_data_dao.dart';
import 'field_data_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [AccountDataEntity, FieldDataEntity])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;
  FieldDataDao get fieldDao;

  sqflite.DatabaseExecutor getDatabaseObject() => this.database;
}

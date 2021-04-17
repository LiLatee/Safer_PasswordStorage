import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import 'package:uuid/uuid.dart';

import 'account_data_dao.dart';
import 'field_data_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [AccountDataEntity, FieldDataEntity])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;
  FieldDataDao get fieldDao;

  sqflite.DatabaseExecutor getDatabaseObject() => this.database;
  // SimpleDao get simpleDao;
}

// @entity
// class SimpleEntity {
//   @primaryKey
//   String? uuid;
//
//   String? name;
//
//   SimpleEntity({this.name}) : uuid = Uuid().v1();
// }
//
// @dao
// abstract class SimpleDao {
//   @Insert(onConflict: OnConflictStrategy.rollback)
//   Future<void> insertAccount(SimpleEntity account);
//
//   @delete
//   Future<void> deleteAccount(SimpleEntity account);
//
//   @update
//   Future<void> updateAccount(SimpleEntity account);
//
//   @Query('SELECT * FROM SimpleEntity WHERE uuid = :uuid')
//   Stream<SimpleEntity?> watchAccountById(String uuid);
// }

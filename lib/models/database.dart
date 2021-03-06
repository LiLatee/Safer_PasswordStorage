import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:mysimplepasswordstorage/models/account_data_dao.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_dao.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'database.g.dart';

@Database(version: 1, entities: [AccountDataEntity, FieldDataEntity])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;
  FieldDataDao get fieldDao;
}
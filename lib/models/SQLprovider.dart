import 'dart:developer';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
class SQLprovider extends ChangeNotifier {
  static final SQLprovider _instance = SQLprovider._internal();
  static final db = SQLprovider();

  factory SQLprovider() {
    return _instance;
  }

  SQLprovider._internal();

  static late AppDatabase _SQL_DB;
  initDB() async {
    _SQL_DB = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  static String getDatabasePath() {
    if (_SQL_DB.getDatabaseObject() is sqflite.Database) {
      var f = _SQL_DB.getDatabaseObject();
      return (f as sqflite.Database).path.toString();
    }
    return "niema"; // TODO

  }



  // SQLprovider() {
  //   init();
  // }

  // late AppDatabase SQL_DB;
  //
  // void init() async {
  //   SQL_DB = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  //   notifyListeners();
  // }

  // Future<AppDatabase> get SQL_DB async {
  //   if (_SQL_DB != null) return _SQL_DB;
  //
  //   _SQL_DB =
  //       await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  //   return _SQL_DB;
  // }

  static Future<void> addAccount({required AccountDataEntity accountDataEntity}) async {
    // await Future.delayed(Duration(seconds: 3));
    return await _SQL_DB.accountDao.insertAccount(accountDataEntity);
  }

  static Future<void> deleteAccount({required AccountDataEntity accountDataEntity}) async {
    await _SQL_DB.accountDao.deleteAccount(accountDataEntity);
  }

  static Stream<List<AccountDataEntity>> watchAllAccounts() {
    return _SQL_DB.accountDao.watchAllAccountsAsStream();
  }

  static Future<List<AccountDataEntity>> getAllAccounts() async {
    return await _SQL_DB.accountDao.getAllAccounts();
  }

  static Future<AccountDataEntity?> getAccountById(String uuid) async {
    return await _SQL_DB.accountDao.getAccountById(uuid);
  }

  // Stream<AccountDataEntity> getAccountById({int id}) {
  //   return SQL_DB.accountDao.watchAccountById(id);
  // }

  // Future<void> setEditButtonState({int accountID, int value}) async {
  //   await SQL_DB.accountDao.setEditButtonState(value, accountID);
  // }
  //
  // Future<void> setShowButtonState({int accountID, int value}) async {
  //   await SQL_DB.accountDao.setShowButtonState(value, accountID);
  // }

  static Future<void> addField({required FieldDataEntity fieldDataEntity}) async {
    await _SQL_DB.fieldDao.insertField(fieldDataEntity);
  }
  static Future<void> updateAccount(AccountDataEntity accountDataEntity) async {
    await _SQL_DB.accountDao.updateAccount(accountDataEntity);
  }

  static Future<void> updateField(FieldDataEntity fieldDataEntity) async {
    await _SQL_DB.fieldDao.updateField(fieldDataEntity);
  }

  static Future<void> deleteField({required FieldDataEntity fieldDataEntity}) async{
    await _SQL_DB.fieldDao.deleteField(fieldDataEntity);
  }

  static Future<List<FieldDataEntity>?> getFieldsOfAccount(
      {required AccountDataEntity accountDataEntity}) async {
    return await _SQL_DB.fieldDao.getFieldsOfAccount(accountDataEntity.uuid!);
  }

  static Stream<List<FieldDataEntity>?> watchFieldsOfAccount(
      {required AccountDataEntity accountDataEntity}) {
    return _SQL_DB.fieldDao.watchFieldsOfAccount(accountDataEntity.uuid!);
  }
}

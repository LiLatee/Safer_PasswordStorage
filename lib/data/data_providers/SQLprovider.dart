import 'dart:developer';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import '../database/database.dart';
import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class SQLprovider {
  static final SQLprovider _instance = SQLprovider._internal();
  static final db = SQLprovider();

  factory SQLprovider() {
    return _instance;
  }

  SQLprovider._internal();

  static late AppDatabase _SQL_DB;
  initDB() async {
    _SQL_DB =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  String? getDatabasePath() {
    if (_SQL_DB.getDatabaseObject() is sqflite.Database) {
      var f = _SQL_DB.getDatabaseObject();
      return (f as sqflite.Database).path.toString();
    }
    return null; // TODO
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

  Future<void> addAccount({required AccountDataEntity accountData}) async {
    // await Future.delayed(Duration(seconds: 3));
    return await _SQL_DB.accountDao.insertAccount(accountData);
  }

  Future<void> deleteAccount({required AccountDataEntity accountData}) async {
    await _SQL_DB.accountDao.deleteAccount(accountData);
  }

  Stream<List<AccountDataEntity>> watchAllAccounts() {
    return _SQL_DB.accountDao.watchAllAccountsAsStream();
  }

  Future<List<AccountDataEntity>> getAllAccounts() async {
    return await _SQL_DB.accountDao.getAllAccounts();
  }

  Future<AccountDataEntity?> getAccountById(String uuid) async {
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

  Future<void> addField({required FieldDataEntity fieldData}) async {
    await _SQL_DB.fieldDao.insertField(fieldData);
  }

  Future<void> updateAccount(AccountDataEntity accountData) async {
    await _SQL_DB.accountDao.updateAccount(accountData);
  }

  Future<void> updateField(FieldDataEntity fieldData) async {
    await _SQL_DB.fieldDao.updateField(fieldData);
  }

  Future<void> deleteField({required FieldDataEntity fieldData}) async {
    await _SQL_DB.fieldDao.deleteField(fieldData);
  }

  Future<List<FieldDataEntity>?> getFieldsOfAccount(
      {required AccountDataEntity accountData}) async {
    return await _SQL_DB.fieldDao.getFieldsOfAccount(accountData.uuid!);
  }

  Stream<List<FieldDataEntity>?> watchFieldsOfAccount(
      {required AccountDataEntity accountData}) {
    return _SQL_DB.fieldDao.watchFieldsOfAccount(accountData.uuid!);
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';

class SQLprovider extends ChangeNotifier {
  SQLprovider() {
    init();
  }

  late AppDatabase SQL_DB;

  void init() async {
    SQL_DB = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    notifyListeners();
  }

  // Future<AppDatabase> get SQL_DB async {
  //   if (_SQL_DB != null) return _SQL_DB;
  //
  //   _SQL_DB =
  //       await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  //   return _SQL_DB;
  // }

  Future<void> addAccount({required AccountDataEntity accountDataEntity}) async {
    // await Future.delayed(Duration(seconds: 3));
    return await SQL_DB.accountDao.insertAccount(accountDataEntity);
  }

  void deleteAccount({required AccountDataEntity accountDataEntity}) {
    SQL_DB.accountDao.deleteAccount(accountDataEntity);
  }

  Stream<List<AccountDataEntity>> watchAllAccounts() {
    return SQL_DB.accountDao.watchAllAccountsAsStream();
  }

  Future<List<AccountDataEntity>> getAllAccounts() async {
    return await SQL_DB.accountDao.getAllAccounts();
  }

  Future<AccountDataEntity?> getAccountById(String uuid) async {
    return await SQL_DB.accountDao.getAccountById(uuid);
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

  Future<void> addField({required FieldDataEntity fieldDataEntity}) async {
    await SQL_DB.fieldDao.insertField(fieldDataEntity);
  }
  Future<void> updateAccount(AccountDataEntity accountDataEntity) async {
    await SQL_DB.accountDao.updateAccount(accountDataEntity);
  }

  Future<void> updateField(FieldDataEntity fieldDataEntity) async {
    await SQL_DB.fieldDao.updateField(fieldDataEntity);
  }

  Future<void> deleteField({required FieldDataEntity fieldDataEntity}) async{
    await SQL_DB.fieldDao.deleteField(fieldDataEntity);
  }

  Future<List<FieldDataEntity>?> getFieldsOfAccount(
      {required AccountDataEntity accountDataEntity}) async {
    return await SQL_DB.fieldDao.getFieldsOfAccount(accountDataEntity.uuid);
  }

  Stream<List<FieldDataEntity>?> watchFieldsOfAccount(
      {required AccountDataEntity accountDataEntity}) {
    return SQL_DB.fieldDao.watchFieldsOfAccount(accountDataEntity.uuid);
  }
}

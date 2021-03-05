import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';

class SQLprovider extends ChangeNotifier{
  SQLprovider() {
    init();
  }

  AppDatabase SQL_DB;

  void init() async {
    SQL_DB =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    notifyListeners();
  }

  // Future<AppDatabase> get SQL_DB async {
  //   if (_SQL_DB != null) return _SQL_DB;
  //
  //   _SQL_DB =
  //       await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  //   return _SQL_DB;
  // }

  void addAccount({AccountDataEntity accountDataEntity}) {
    SQL_DB.accountDao.insertAccount(accountDataEntity);
  }

  Stream<List<AccountDataEntity>> watchAllAccounts() {
    return SQL_DB.accountDao.watchAllAccountsAsStream();
  }

  Future<List<AccountDataEntity>> getAllAccounts() async {
    return await SQL_DB.accountDao.getAllAccounts();
  }

  Stream<AccountDataEntity> getAccountById({int id}) {
    return SQL_DB.accountDao.watchAccountById(id);
  }

  void addField({FieldDataEntity fieldDataEntity}) {
    SQL_DB.fieldDao.insertField(fieldDataEntity);
  }

  void removeField({FieldDataEntity fieldDataEntity}) {
    SQL_DB.fieldDao.deleteField(fieldDataEntity);
  }

  Stream<List<FieldDataEntity>> watchFieldsOfAccount(
      {AccountDataEntity accountDataEntity}) {
    return SQL_DB.fieldDao.watchFieldsOfAccount(accountDataEntity.id);
  }

  void setEditButtonState({int accountID, int value}) {
    SQL_DB.accountDao.setEditButtonState(value, accountID);
  }

  Future<void> setShowButtonState({int accountID, int value}) {
    SQL_DB.accountDao.setShowButtonState(value, accountID);
  }

}

import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';

class DBProvider extends ChangeNotifier {
  DBProvider._() {
    // addAccount(acc: AccountDataEntity(accountName: "Test1"));
    // addAccount(acc: AccountDataEntity(accountName: "Test2"));
    // addField(fieldDataEntity: FieldDataEntity(accountId: 1, name: "Moje pole 2", value: "Taka se wartość2", position: 2));
    // addField(fieldDataEntity: FieldDataEntity(accountId: 1, name: "Moje pole 1", value: "Taka se wartość1", position: 1));
    // addField(fieldDataEntity: FieldDataEntity(accountId: 2, name: "Moje pole 11", value: "Taka se wartość22", position: 1));
  }

  static final DBProvider db = DBProvider._();

  AppDatabase _SQL_DB;

  Future<AppDatabase> get SQL_DB async {
    if (_SQL_DB != null) return _SQL_DB;

    _SQL_DB =
    await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    return _SQL_DB;
  }

  Future<List<AccountDataEntity>> getAllAccounts() async {
    final sqlDB = await SQL_DB;
    return await sqlDB.accountDao.getAllAccounts();
  }

  void addAccount({AccountDataEntity acc}) async {
    final sqlDB = await SQL_DB;
    sqlDB.accountDao.insertAccount(acc);
  }

  Future<AccountDataEntity> getAccountById({int id}) async {
    final sqlDB = await SQL_DB;
    return sqlDB.accountDao.getAccountById(id);
  }

  Future<void> addField({FieldDataEntity fieldDataEntity}) async {
    final sqlDB = await SQL_DB;
    sqlDB.fieldDao.insertField(fieldDataEntity);
  }

  Future<void> removeField({FieldDataEntity fieldDataEntity}) async {
    final sqlDB = await SQL_DB;
    sqlDB.fieldDao.deleteField(fieldDataEntity);
  }

  Future<List<FieldDataEntity>> getAllFieldsOfAccount(
      {AccountDataEntity accountDataEntity}) async {
    final sqlDB = await SQL_DB;
    await Future.delayed(Duration(seconds: 2));
    return await sqlDB.fieldDao.getAllFieldsOfAccount(accountDataEntity.id);

  }

  Future<void> setEditButtonState({int accountID, int value}) async {
    final sqlDB = await SQL_DB;
    sqlDB.accountDao.setEditButtonState(value, accountID);
  }

  Future<void> setShowButtonState({int accountID, int value}) async {
    final sqlDB = await SQL_DB;
    sqlDB.accountDao.setShowButtonState(value, accountID);
  }

// void addFieldToAcc({FieldDataEntity field})
}

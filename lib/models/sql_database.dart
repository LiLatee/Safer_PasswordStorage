import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';

class DBProvider extends ChangeNotifier {
  DBProvider._() {
    addAccount(acc:  AccountDataEntity(accountName: "Test1"));
    addAccount(acc:  AccountDataEntity(accountName: "Test2"));
  }
  static final DBProvider db = DBProvider._();

  AppDatabase _SQL_DB;

  Future<AppDatabase> get SQL_DB async {
    if (_SQL_DB != null)
      return _SQL_DB;

    _SQL_DB = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    return _SQL_DB;
  }

  void addAccount({AccountDataEntity acc}) async {
    final sqlDB = await SQL_DB;
    sqlDB.accountDao.insertAccount(acc);
  }

  Future<AccountDataEntity> getAccountById({int id}) async{
    final sqlDB = await SQL_DB;
    return sqlDB.accountDao.getAccountById(id);
  }

  // void addFieldToAcc({FieldDataEntity field})
}

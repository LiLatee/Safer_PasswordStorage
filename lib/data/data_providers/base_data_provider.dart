import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';

abstract class BaseDataProvider {
  Future<void> addAccount({required AccountDataEntity accountData});

  Future<void> deleteAccount({required AccountDataEntity accountData});

  Future<void> updateAccount({required AccountDataEntity accountData});

  Future<AccountDataEntity?> getAccountById(String uuid);

  Future<List<AccountDataEntity>> getAllAccounts();

  Future<void> addField({required FieldDataEntity fieldData});

  Future<void> updateField({required FieldDataEntity fieldData});

  Future<void> deleteField({required FieldDataEntity fieldData});

  Future<List<FieldDataEntity>?> getFieldsOfAccount(
      {required AccountDataEntity accountData});
}

// import 'package:sqflite/sqflite.dart' as sqflite;

// import '../database/database.dart';
// import '../models/account_data_entity.dart';
// import '../models/field_data_entity.dart';

// class BaseDataProvider {

//   AccountDataEntity addAccount({required AccountDataEntity accountData}) {

//     accountData
//     return await _SQL_DB.accountDao.addAccount(accountData);
//   }

//   AccountDataEntity deleteAccount({required AccountDataEntity accountData}) {
//     await _SQL_DB.accountDao.deleteAccount(accountData);
//   }

//   AccountDataEntity updateAccount(AccountDataEntity accountData) {
//     await _SQL_DB.accountDao.updateAccount(accountData);
//   }

//   List<AccountDataEntity?> getAccountById(String uuid) {
//     return await _SQL_DB.accountDao.getAccountById(uuid);
//   }

//   List<AccountDataEntity> getAllAccounts() {
//     return await _SQL_DB.accountDao.getAllAccounts();
//   }

//   AccountDataEntity addField({required FieldDataEntity fieldData}) {
//     await _SQL_DB.fieldDao.insertField(fieldData);
//   }

//   AccountDataEntity updateField(FieldDataEntity fieldData) {
//     await _SQL_DB.fieldDao.updateField(fieldData);
//   }

//   Future<void> deleteField({required FieldDataEntity fieldData}) {
//     await _SQL_DB.fieldDao.deleteField(fieldData);
//   }

//   List<FieldDataEntity>? getFieldsOfAccount(
//       {required AccountDataEntity accountData}) {
//     return await _SQL_DB.fieldDao.getFieldsOfAccount(accountData.uuid!);
//   }
// }

// import 'package:sqflite/sqflite.dart' as sqflite;

// import '../database/database.dart';
// import '../models/account_data_entity.dart';
// import '../models/field_data_entity.dart';

// abstract class BaseDataProvider {
//   AccountDataEntity addAccount({required AccountDataEntity accountData});

//   AccountDataEntity deleteAccount({required AccountDataEntity accountData});

//   AccountDataEntity updateAccount(AccountDataEntity accountData);

//   List<AccountDataEntity?> getAccountById(String uuid);

//   List<AccountDataEntity> getAllAccounts();

//   AccountDataEntity addField({required FieldDataEntity fieldData});

//   AccountDataEntity updateField(FieldDataEntity fieldData);

//   Future<void> deleteField({required FieldDataEntity fieldData});

//   List<FieldDataEntity>? getFieldsOfAccount(
//       {required AccountDataEntity accountData});
// }

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

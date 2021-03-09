import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';

@dao
abstract class AccountDao extends ChangeNotifier{
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<int> insertAccount(AccountDataEntity account);

  @delete
  Future<void> deleteAccount(AccountDataEntity account);

  @update
  Future<void> updateAccount(AccountDataEntity account);

  // @Query('EXISTS(SELECT * FROM AccountDataEntity WHERE accountName = :name)')
  // Future<bool> isNameUsed(String name);

  @Query('SELECT * FROM AccountDataEntity')
  Stream<List<AccountDataEntity>> watchAllAccountsAsStream();

  @Query('SELECT * FROM AccountDataEntity')
  Future<List<AccountDataEntity>> getAllAccounts();

  @Query('SELECT * FROM AccountDataEntity WHERE id = :id')
  Future<AccountDataEntity> getAccountById(int id);

  // @Query('SELECT * FROM AccountDataEntity WHERE accountName = :name')
  // Future<List<AccountDataEntity>> getAccountByName(String name);

  @Query('SELECT * FROM AccountDataEntity WHERE id = :id')
  Stream<AccountDataEntity> watchAccountById(int id);

  // @Query("UPDATE AccountDataEntity SET isShowButtonPressed = :value WHERE id = :accountID")
  // Future<void> setShowButtonState(int value, int accountID) {
  //   // notifyListeners();
  //   return null;
  // }
  //
  // @Query("UPDATE AccountDataEntity SET isEditButtonPressed = :value WHERE id = :accountID")
  // Future<void> setEditButtonState(int value, int accountID) {
  //   // notifyListeners();
  //   return null;
  // }

}
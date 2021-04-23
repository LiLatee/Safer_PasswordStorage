import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

import '../models/account_data_entity.dart';

@dao
abstract class AccountDao extends ChangeNotifier {
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> addAccount(AccountDataEntity account);

  @delete
  Future<void> deleteAccount(AccountDataEntity account);

  @update
  Future<void> updateAccount(AccountDataEntity account);

  // @Query('EXISTS(SELECT * FROM AccountDataEntity WHERE accountName = :name)')
  // Future<bool> isNameUsed(String name);

  @Query('SELECT * FROM AccountDataEntity')
  Future<List<AccountDataEntity>> getAllAccounts();

  @Query('SELECT * FROM AccountDataEntity WHERE uuid = :uuid')
  Future<AccountDataEntity?> getAccountById(String uuid);
}

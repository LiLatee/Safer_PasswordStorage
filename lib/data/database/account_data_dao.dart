import 'package:floor/floor.dart';

import '../models/account_data_entity.dart';

@dao
abstract class AccountDao {
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

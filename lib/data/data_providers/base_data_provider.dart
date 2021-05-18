import 'package:my_simple_password_storage_clean/data/entities/app_secret_key_entity.dart';

import '../entities/account_data_entity.dart';
import '../entities/field_data_entity.dart';

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

  // Future<void> saveAppSecretKey(
  //     {required AppSecretKeyEntity appSecretKeyEntity});
}

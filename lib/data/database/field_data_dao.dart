import 'package:floor/floor.dart';

import '../models/field_data_entity.dart';

@dao
abstract class FieldDataDao {
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insertField(FieldDataEntity field);

  @delete
  Future<void> deleteField(FieldDataEntity field);

  @update
  Future<void> updateField(FieldDataEntity field);

  @Query('SELECT * FROM FieldDataEntity WHERE accountId = :accountId')
  Future<List<FieldDataEntity>?> getFieldsOfAccount(String accountId);
}

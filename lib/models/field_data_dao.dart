import 'package:floor/floor.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';

@dao
abstract class FieldDataDao {
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insertField(FieldDataEntity field);

  @delete
  Future<void> deleteField(FieldDataEntity field);

  @update
  Future<void> updateField(FieldDataEntity field);

  @Query('SELECT * FROM FieldDataEntity WHERE accountId = :accountId')
  Stream<List<FieldDataEntity>> watchFieldsOfAccount(int accountId);

  // @Query("SELECT COUNT(*) FROM FieldDataEntity WHERE id = :accountId")
  // Future<int> getNumberOfFieldsOfAccountId({int accountId});

  // @Query('DELETE FROM FieldDataEntity WHERE id = :id')
  // Future<void> removeFieldAt(int id);


}
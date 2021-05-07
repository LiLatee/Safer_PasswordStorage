import 'package:floor/floor.dart';
import 'package:my_simple_password_storage_clean/data/models/app_secret_key_entity.dart';

@dao
abstract class AppSecretKeyDao {
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insert(AppSecretKeyEntity field);

  // @delete
  // Future<void> deleteField(AppSecretKeyEntity field);

  // @update
  // Future<void> updateField(AppSecretKeyEntity field);

  @Query('DELETE FROM AppSecretKeyEntity')
  Future<void> delete();

  @Query('SELECT * FROM AppSecretKeyEntity LIMIT 1')
  Future<AppSecretKeyEntity?> getAppSecretKeyEntity();
}

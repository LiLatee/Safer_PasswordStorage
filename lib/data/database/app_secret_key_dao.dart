import 'package:aes_crypt/aes_crypt.dart';
import 'package:floor/floor.dart';
import 'package:my_simple_password_storage_clean/data/models/app_secret_key_entity.dart';

@dao
abstract class AppSecretKeyDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(AppSecretKeyEntity field);

  // @delete
  // Future<void> deleteField(AppSecretKeyEntity field);

  // @update
  // Future<void> updateField(AppSecretKeyEntity field);

  @Query('DELETE FROM AppSecretKeyEntity')
  Future<void> delete();

  @Query('SELECT * FROM AppSecretKeyEntity LIMIT 1')
  Future<AppSecretKeyEntity?> getAppSecretKeyEntity();

  @transaction
  Future<String> exportAppSecretKey(
    AesCrypt aesCrypt,
    String databasePath,
    String path,
  ) async {
    await insert(AppSecretKeyEntity());
    var exportedDataPath = aesCrypt.encryptFile(
      databasePath,
      path,
    );
    // throw Exception();
    await delete();
    return exportedDataPath;
  }

  @transaction
  Future<void> importAppSecretKey() async {
    await getAppSecretKeyEntity();
    await delete();
  }
}

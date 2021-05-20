import 'package:aes_crypt/aes_crypt.dart';
import 'package:floor/floor.dart';

import '../entities/app_secret_key_entity.dart';

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

  // @transaction
  Future<String> exportAppSecretKey(
    AesCrypt aesCrypt,
    String databasePath,
    String path,
  ) async {
    await insert(AppSecretKeyEntity());
    // log("Key to EXPORT: ${AppSecretKeyEntity().key}");
    var exportedDataPath = aesCrypt.encryptFileSync(
      databasePath,
      path,
    );
    // log("koniec EXPORT");
    // log("Klucz w SQL przed usunięciem: ${(await getAppSecretKeyEntity())!.key}");
    await delete();
    // log("usunięto KEY");

    return exportedDataPath;
  }

  // @transaction
  Future<void> importAppSecretKey() async {
    // try {
    //   await getAppSecretKeyEntity();
    //   log("EEE: ${(await getAppSecretKeyEntity())!.key}");
    // } catch (e) {
    //   log("ERROR: $e");
    // }
    await getAppSecretKeyEntity();
    await delete();
  }
}

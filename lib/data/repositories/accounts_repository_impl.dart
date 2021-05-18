import 'dart:developer';
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/errors/failures.dart';
import '../../logic/cubit/general/app_key_cubit.dart';
import '../data_providers/SQLprovider.dart';
import '../data_providers/base_data_provider.dart';
import '../entities/account_data_entity.dart';
import '../entities/app_secret_key_entity.dart';
import '../entities/field_data_entity.dart';
import 'accounts_repository.dart';

class AccountsRepositoryImlp extends AccountsRepository {
  final BaseDataProvider sqlProvider;

  AccountsRepositoryImlp({required this.sqlProvider});

  /// Accounts methods.
  ///
  ///

  //! Accounts
  @override
  Future<Either<Failure, void>> addAccountLogic(
      {required AccountDataEntity accountData}) async {
    try {
      return Right(await sqlProvider.addAccount(accountData: accountData));
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(
      {required AccountDataEntity accountData}) async {
    try {
      return Right(await sqlProvider.deleteAccount(accountData: accountData));
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccountLogic(
      {required AccountDataEntity accountData}) async {
    try {
      for (var field in accountData.fields)
        await sqlProvider.updateField(fieldData: field);

      return Right(await sqlProvider.updateAccount(accountData: accountData));
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, AccountDataEntity?>> getAccountById(
  //     String uuid) async {
  //   var account = await sqlProvider.getAccountById(uuid);
  //   if (account != null)
  //     account.fields =
  //         (await sqlProvider.getFieldsOfAccount(accountData: account))!;

  //   return Right(account);
  // }

  @override
  Future<Either<Failure, List<AccountDataEntity>>> getAllAccountsLogic() async {
    try {
      var accounts = await sqlProvider.getAllAccounts();

      for (var acc in accounts) {
        List<FieldDataEntity>? fields =
            await sqlProvider.getFieldsOfAccount(accountData: acc);

        acc.fields = fields ?? [];
        acc.fields.sort((a, b) => a.position.compareTo(b.position));
        acc.setIconWidget();
      }
      return Right(accounts);
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  //! Single Account operations.

  @override
  Future<Either<Failure, void>> addFieldLogic(
      {required FieldDataEntity fieldData}) async {
    try {
      return Right(await sqlProvider.addField(fieldData: fieldData));
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteField(
      {required FieldDataEntity fieldData}) async {
    try {
      return Right(await sqlProvider.deleteField(fieldData: fieldData));
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, void>> updateField(FieldDataEntity fieldData) async {
  //   return Right(await sqlProvider.updateField(fieldData: fieldData));
  // }

  // @override
  // Future<Either<Failure, List<FieldDataEntity>?>> getFieldsOfAccount(
  //     {required AccountDataEntity accountData}) async {
  //   return Right(
  //       await sqlProvider.getFieldsOfAccount(accountData: accountData));
  // }

  //! Import/Export
  @override
  Future<Either<Failure, void>> importEncryptedDatabase(
      {required String secretKey,
      required String filepath,
      required AppKeyCubit appKeyCubit}) async {
    try {
      String databasePath = (sqlProvider as SQLprovider).getDatabasePath();
      if (databasePath == null) {
        return Left(SqlLiteFailure(message: "SQLite database path not found."));
      } else {
        var crypt = AesCrypt(secretKey);
        crypt.setOverwriteMode(AesCryptOwMode.on);
        try {
          // await Future.delayed(Duration(seconds: 2));
          crypt.decryptFileSync(filepath, databasePath);
        } on Exception {
          return Left(BackupDecryptionFailure(message: "importing failed"));
        }
        await (sqlProvider as SQLprovider).importAppSecretKey();
        log("Ustawianie klucza po IMPORT: ${AppSecretKeyEntity().key}");
        appKeyCubit.setKey(key: AppSecretKeyEntity().key);
        return Right(null);
      }
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportEncryptedDatabase(
      {required String secretKey}) async {
    try {
      if (await Permission.storage.request().isGranted) {
        DateTime now = DateTime.now();
        String filename =
            "MySimplePasswordStorage Backup ${now.year}-${now.month}-${now.day} ${now.hour}-${now.minute}-${now.second}.aes";
        String path = "/storage/emulated/0/Download/" + filename;

        var aesCrypt = AesCrypt(secretKey);
        String databasePath = (sqlProvider as SQLprovider).getDatabasePath();
        String exportedDataPath;
        if (databasePath == null) {
          return Left(
              SqlLiteFailure(message: "SQLite database path not found."));
        } else {
          try {
            log("Przed export KEY: ${databasePath}");
            exportedDataPath = await (sqlProvider as SQLprovider)
                .exportAppSecretKey(
                    aesCrypt: aesCrypt, databasePath: databasePath, path: path);
          } on FileSystemException catch (e) {
            return Left(BackupEncryptionFailure(e.toString()));
          }
          log("Backup saved: $path");
          return Right(exportedDataPath);
        }
      } else
        return Left(ReadWritePermissionNotGrantedFailure());
    } catch (e) {
      return Left(SqlLiteFailure(message: e.toString()));
    }
  }
}

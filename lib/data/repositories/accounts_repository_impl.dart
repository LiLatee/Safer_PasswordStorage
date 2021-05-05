import 'dart:developer';
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/errors/failures.dart';
import '../data_providers/base_data_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data_providers/SQLprovider.dart';
import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';
import 'accounts_repository.dart';

class AccountsRepositoryImlp implements AccountsRepository {
  final BaseDataProvider sqlProvider;

  AccountsRepositoryImlp({required this.sqlProvider});

  /// Accounts methods.
  ///
  ///

  @override
  Future<Either<Failure, void>> addAccount(
      {required AccountDataEntity accountData}) async {
    return Right(await sqlProvider.addAccount(accountData: accountData));
  }

  @override
  Future<Either<Failure, void>> deleteAccount(
      {required AccountDataEntity accountData}) async {
    return Right(await sqlProvider.deleteAccount(accountData: accountData));
  }

  @override
  Future<Either<Failure, void>> updateAccount(
      AccountDataEntity accountData) async {
    for (var field in accountData.fields)
      await sqlProvider.updateField(fieldData: field);

    return Right(await sqlProvider.updateAccount(accountData: accountData));
  }

  @override
  Future<Either<Failure, AccountDataEntity?>> getAccountById(
      String uuid) async {
    var account = await sqlProvider.getAccountById(uuid);
    if (account != null)
      account.fields =
          (await sqlProvider.getFieldsOfAccount(accountData: account))!;

    return Right(account);
  }

  @override
  Future<Either<Failure, List<AccountDataEntity>>> getAllAccounts() async {
    var accounts = await sqlProvider.getAllAccounts();
    for (var acc in accounts) {
      List<FieldDataEntity>? fields =
          await sqlProvider.getFieldsOfAccount(accountData: acc);
      acc.fields = fields ?? [];
      acc.fields.sort((a, b) => a.position.compareTo(b.position));
      acc.setIconWidget();
    }
    return Right(accounts);
  }

  /// Fields methods.
  ///
  ///

  @override
  Future<Either<Failure, void>> addField(
      {required FieldDataEntity fieldData}) async {
    return Right(await sqlProvider.addField(fieldData: fieldData));
  }

  @override
  Future<Either<Failure, void>> deleteField(
      {required FieldDataEntity fieldData}) async {
    return Right(await sqlProvider.deleteField(fieldData: fieldData));
  }

  @override
  Future<Either<Failure, void>> updateField(FieldDataEntity fieldData) async {
    return Right(await sqlProvider.updateField(fieldData: fieldData));
  }

  @override
  Future<Either<Failure, List<FieldDataEntity>?>> getFieldsOfAccount(
      {required AccountDataEntity accountData}) async {
    return Right(
        await sqlProvider.getFieldsOfAccount(accountData: accountData));
  }

  @override
  Future<Either<Failure, void>> importEncryptedDatabase(
      {required String secretKey, required String filepath}) async {
    String databasePath = (sqlProvider as SQLprovider).getDatabasePath();

    if (databasePath == null)
      return Left(SqlLiteFailure());
    else {
      var crypt = AesCrypt(secretKey);
      crypt.setOverwriteMode(AesCryptOwMode.on);
      try {
        // await Future.delayed(Duration(seconds: 2));
        crypt.decryptFileSync(filepath, databasePath);
      } on Exception {
        return Left(BackupDecryptionFailure());
      }
      return Right(null);
    }
  }

  @override
  Future<Either<Failure, String>> exportEncryptedDatabase(
      {required String secretKey}) async {
    if (await Permission.storage.request().isGranted) {
      DateTime now = DateTime.now();
      String filename =
          "MySimplePasswordStorage Backup ${now.year}-${now.month}-${now.day} ${now.hour}-${now.minute}-${now.second}.aes";
      String path = "/storage/emulated/0/Download/" + filename;

      var crypt = AesCrypt(secretKey);
      String databasePath = (sqlProvider as SQLprovider).getDatabasePath();
      String exportedDataPath;
      if (databasePath == null)
        return Left(SqlLiteFailure());
      else {
        try {
          exportedDataPath = crypt.encryptFileSync(
            databasePath,
            path,
          );
        } on FileSystemException {
          return Left(BackupEncryptionFailure());
        }
        log("Backup saved: $path");
        return Right(exportedDataPath);
      }
    } else
      return Left(ReadWritePermissionNotGrantedFailure());
  }
}

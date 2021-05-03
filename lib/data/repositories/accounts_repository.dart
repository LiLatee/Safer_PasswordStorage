import 'dart:developer';
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data_providers/SQLprovider.dart';
import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';

class AccountsRepository {
  final SQLprovider sqlProvider;
  late final String key;

  AccountsRepository({required this.sqlProvider});

  Future<void> addAccount({required AccountDataEntity accountData}) async {
    // await Future.delayed(Duration(seconds: 3));
    return await sqlProvider.addAccount(accountData: accountData);
  }

  Future<void> updateAccount(AccountDataEntity accountData) async {
    for (var field in accountData.fields) sqlProvider.updateField(field);

    await sqlProvider.updateAccount(accountData);
  }

  Future<void> deleteAccount({required AccountDataEntity accountData}) async {
    await sqlProvider.deleteAccount(accountData: accountData);
  }

  Future<List<AccountDataEntity>> getAllAccounts() async {
    // await Future.delayed(Duration(seconds: 2)); // TODO
    var accounts = await sqlProvider.getAllAccounts();
    for (var acc in accounts) {
      List<FieldDataEntity>? fields =
          await sqlProvider.getFieldsOfAccount(accountData: acc);
      acc.fields = fields ?? [];
      acc.fields.sort((a, b) => a.position.compareTo(b.position));
      acc.setIconWidget();
    }
    return accounts;
  }

  Future<AccountDataEntity?> getAccountById(String uuid) async {
    var account = await sqlProvider.getAccountById(uuid);
    if (account != null)
      account.fields =
          (await sqlProvider.getFieldsOfAccount(accountData: account))!;

    return account;
  }

  Future<void> addField({required FieldDataEntity fieldData}) async {
    await sqlProvider.addField(fieldData: fieldData);
  }

  Future<void> updateField(FieldDataEntity fieldData) async {
    await sqlProvider.updateField(fieldData);
  }

  Future<void> deleteField({required FieldDataEntity fieldData}) async {
    await sqlProvider.deleteField(fieldData: fieldData);
  }

  Future<List<FieldDataEntity>?> getFieldsOfAccount(
      {required AccountDataEntity accountData}) async {
    return await sqlProvider.getFieldsOfAccount(accountData: accountData);
  }

  Future<AsyncSnapshot<String>> exportEncryptedDatabase(
      String secretKey, BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      DateTime now = DateTime.now();
      String filename =
          "MySimplePasswordStorage Backup ${now.year}-${now.month}-${now.day} ${now.hour}-${now.minute}-${now.second}.aes";
      String path = "/storage/emulated/0/Download/" + filename;

      var crypt = AesCrypt(secretKey);
      String databasePath = sqlProvider.getDatabasePath();

      if (databasePath != null) {
        var result;
        try {
          result = crypt.encryptFileSync(
            databasePath,
            path,
          );
        } on FileSystemException catch (e, stack) {
          print(AesCryptFsException(
              'Failed to open file $path for writing.', e.path, e.osError));
          print(stack);

          return AsyncSnapshot.withError(ConnectionState.done,
              AppLocalizations.of(context)!.encryptionError);
        }

        log("Backup saved: $path");
        return AsyncSnapshot.withData(ConnectionState.done,
            AppLocalizations.of(context)!.dataExported(result));
      } else
        return AsyncSnapshot.withError(
            ConnectionState.done, AppLocalizations.of(context)!.sqlNotFound);
    }
    return AsyncSnapshot.withError(ConnectionState.done,
        AppLocalizations.of(context)!.noRequiredPermissions);
  }

  Future<AsyncSnapshot<String>> importEncryptedDatabase(
      {required BuildContext context,
      required String secretKey,
      required String filepath}) async {
    String databasePath = sqlProvider.getDatabasePath();

    if (databasePath != null) {
      var crypt = AesCrypt(secretKey);
      crypt.setOverwriteMode(AesCryptOwMode.on);

      try {
        // await Future.delayed(Duration(seconds: 2));
        crypt.decryptFileSync(filepath, databasePath);
      } on Exception {
        return AsyncSnapshot.withError(ConnectionState.done,
            AppLocalizations.of(context)!.decryptionFailed);
      }

      return AsyncSnapshot.withData(
          ConnectionState.done, AppLocalizations.of(context)!.importSuccess);
    } else {
      return AsyncSnapshot.withError(
          ConnectionState.done, AppLocalizations.of(context)!.sqlNotFound);
    }
  }
}

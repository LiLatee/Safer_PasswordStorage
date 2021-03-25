import 'dart:developer';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;
import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class DataProvider extends ChangeNotifier {
  static final DataProvider _instance = DataProvider._internal();
  static final dp = DataProvider();

  factory DataProvider() {
    return _instance;
  }

  DataProvider._internal();

  initDataProvider() async {
    await SQLprovider.db.initDB();
    fetchAndSetData();
  }

  static List<AccountDataEntity> accounts = [];
  static BehaviorSubject<List<AccountDataEntity>> _subjectAccounts =
      BehaviorSubject<List<AccountDataEntity>>();

  static Stream<List<AccountDataEntity>> get accountsStream =>
      _subjectAccounts.stream;

  AccountDataEntity? getLocalAccountById(int id) {
    for (var acc in accounts) if (acc.uuid == id) return acc;
    return null;
  }

  static bool isAccountNameUsed({required String name}) {
    bool isUsed = false;
    for (var el in accounts) {
      if (el.accountName.toLowerCase() == name.toLowerCase()) {
        isUsed = true;
        break;
      }
    }
    return isUsed;
  }

  static Future<void> fetchAndSetData() async {
    accounts = await SQLprovider.getAllAccounts();
    for (var acc in accounts) {
      List<FieldDataEntity>? fields =
          await SQLprovider.getFieldsOfAccount(accountDataEntity: acc);
      acc.fields = fields ?? [];
      acc.fields.sort((a, b) => a.position.compareTo(b.position));
      acc.setIconWidget();
    }

    _subjectAccounts.sink.add(accounts);
    // notifyListeners();
  }

  static void addAccount(AccountDataEntity accountDataEntity) async {
    await SQLprovider.addAccount(accountDataEntity: accountDataEntity);
    //     .then((value) async {
    //     var acc = await sql_provider.getAccountById(value);
    //     acc.fields = accountDataEntity.fields;
    //     accounts.add(acc);
    //     _subjectAccounts.sink.add(accounts);
    // });
    SQLprovider.getAccountById(accountDataEntity.uuid!)
        .then((AccountDataEntity? addedAcc) {
      addedAcc!.fields = accountDataEntity.fields;
      accounts.add(addedAcc);
      _subjectAccounts.sink.add(accounts);
    });
  }

  static void updateAccount(AccountDataEntity accountDataEntity) {
    int listIndex = accounts
        .indexWhere((element) => element.uuid == accountDataEntity.uuid);

    accounts[listIndex] = accountDataEntity;

    for (var field in accounts[listIndex].fields)
      SQLprovider.updateField(field);

    _subjectAccounts.sink.add(accounts);
    SQLprovider.updateAccount(accountDataEntity);
  }

  static void deleteAccount(AccountDataEntity accountDataEntity) {
    SQLprovider.deleteAccount(accountDataEntity: accountDataEntity);
    accounts.remove(accountDataEntity);
    _subjectAccounts.sink.add(accounts);
  }

  static void toggleEditButton({required AccountDataEntity accountDataEntity}) {
    int listIndex = accounts
        .indexWhere((element) => element.uuid == accountDataEntity.uuid);
    if (accountDataEntity.isEditButtonPressed == true) {
      accounts[listIndex].isEditButtonPressed = false;
    } else {
      accounts[listIndex].isEditButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  static void toggleShowButton({required AccountDataEntity accountDataEntity}) {
    int listIndex = accounts
        .indexWhere((element) => element.uuid == accountDataEntity.uuid);

    if (accountDataEntity.isShowButtonPressed == true) {
      accounts[listIndex].isShowButtonPressed = false;
    } else {
      accounts[listIndex].isShowButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  static void addField(FieldDataEntity fieldDataEntity) {
    int listIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    fieldDataEntity.position = accounts[listIndex].getNextFieldPosition();
    accounts[listIndex].fields.add(fieldDataEntity);
    _subjectAccounts.sink.add(accounts);
    SQLprovider.addField(fieldDataEntity: fieldDataEntity);
  }

  static void updateField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    int fieldListIndex = accounts[accListIndex]
        .fields
        .indexWhere((element) => element.uuid == fieldDataEntity.uuid);

    accounts[accListIndex].fields[fieldListIndex] = fieldDataEntity;

    SQLprovider.updateField(fieldDataEntity);
  }

  static void deleteField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    accounts[accListIndex].fields.remove(fieldDataEntity);
    _subjectAccounts.sink.add(accounts);

    SQLprovider.deleteField(fieldDataEntity: fieldDataEntity);
  }
  static Future<AsyncSnapshot<String>> exportEncryptedDatabase(String secretKey, BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      DateTime now = DateTime.now();
      String filename =
          "MySimplePasswordStorage Backup ${now.year}-${now.month}-${now.day} ${now.hour}-${now.minute}-${now.second}.aes";
      String path = "/storage/emulated/0/Download/" + filename;

      var crypt = AesCrypt(secretKey);
      String? databasePath = SQLprovider.getDatabasePath();

      if (databasePath != null) {
        var result = crypt.encryptFileSync(
          databasePath,
          path,
        );
        log("Backup saved: $path");
        return AsyncSnapshot.withData(ConnectionState.done, "Your data has been saved in $result.");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Your data has been saved in $result."),
        //   duration: Duration(seconds: 5),
        // ));

      } else
        return AsyncSnapshot.withError(ConnectionState.done, "SQLDatabase not found.");
        // throw ("SQLDatabase not found.");
    }
    return AsyncSnapshot.withError(ConnectionState.done, "Required permissions not granted.");
  }

  static Future<AsyncSnapshot<String>> importEncryptedDatabase(
      {required String secretKey, required String filepath}) async {
    String? databasePath = SQLprovider.getDatabasePath();

    if (databasePath != null) {
      var crypt = AesCrypt(secretKey);
      crypt.setOverwriteMode(AesCryptOwMode.on);

      try {
        // await Future.delayed(Duration(seconds: 2));
        crypt.decryptFileSync(filepath, databasePath);
      } on Exception {
        return AsyncSnapshot.withError(ConnectionState.done,
            "Decryption failed. Did you choose right file and entered correct password?");
      }

      fetchAndSetData();
      return AsyncSnapshot.withData(
          ConnectionState.done, "Data has been correctly imported.");
    } else {
      // User canceled the picker
      return AsyncSnapshot.withError(
          ConnectionState.done, "Error: cannot find path to database.");
    }
  }
}

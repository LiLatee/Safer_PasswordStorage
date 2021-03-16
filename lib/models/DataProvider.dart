import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
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
  static BehaviorSubject<List<AccountDataEntity>> _subjectAccounts = BehaviorSubject<List<AccountDataEntity>>();

  static Stream<List<AccountDataEntity>> get accountsStream => _subjectAccounts.stream;

  AccountDataEntity? getLocalAccountById(int id) {
    for (var acc in accounts)
      if (acc.uuid == id) return acc;
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
    SQLprovider.getAccountById(accountDataEntity.uuid!).then((
        AccountDataEntity? addedAcc) {
      addedAcc!.fields = accountDataEntity.fields;
      accounts.add(addedAcc);
      _subjectAccounts.sink.add(accounts);
    });
  }

  static void updateAccount(AccountDataEntity accountDataEntity) {
    int listIndex =
    accounts.indexWhere((element) => element.uuid == accountDataEntity.uuid);
    accounts[listIndex] = accountDataEntity;
    SQLprovider.updateAccount(accountDataEntity);
  }

  static void deleteAccount(AccountDataEntity accountDataEntity) {
    SQLprovider.deleteAccount(accountDataEntity: accountDataEntity);
    accounts.remove(accountDataEntity);
    _subjectAccounts.sink.add(accounts);
  }

  static void toggleEditButton({required AccountDataEntity accountDataEntity}) {
    int listIndex =
    accounts.indexWhere((element) => element.uuid == accountDataEntity.uuid);
    if (accountDataEntity.isEditButtonPressed == true) {
      accounts[listIndex].isEditButtonPressed = false;
    } else {
      accounts[listIndex].isEditButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  static void toggleShowButton({required AccountDataEntity accountDataEntity}) {
    int listIndex =
    accounts.indexWhere((element) => element.uuid == accountDataEntity.uuid);

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

    SQLprovider
        .updateField(fieldDataEntity);
  }

  static void deleteField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    accounts[accListIndex].fields.remove(fieldDataEntity);

    SQLprovider
        .deleteField(fieldDataEntity: fieldDataEntity);
  }
}
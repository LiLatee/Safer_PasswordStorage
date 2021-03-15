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
  final SQLprovider sql_provider;

  List<AccountDataEntity> accounts = [];
  BehaviorSubject<List<AccountDataEntity>> _subjectAccounts;

  DataProvider({required this.sql_provider}) : _subjectAccounts = BehaviorSubject<List<AccountDataEntity>>(){
    ;
    if (sql_provider != null) {
      fetchAndSetData();
    }
  }

  Stream<List<AccountDataEntity>> get accountsStream => _subjectAccounts.stream;

  AccountDataEntity? getLocalAccountById(int id) {
    for (var acc in accounts) if (acc.uuid == id) return acc;
    return null;
  }

  bool isAccountNameUsed({required String name}) {
    bool isUsed = false;
    for (var el in accounts) {
      if (el.accountName.toLowerCase() == name.toLowerCase()) {
        isUsed = true;
        break;
      }
    }
    return isUsed;
  }

  Future<void> fetchAndSetData() async {
    if (sql_provider.SQL_DB != null) {

      accounts = await sql_provider.getAllAccounts();
      for (var acc in accounts) {
        List<FieldDataEntity> fields =
            await sql_provider.getFieldsOfAccount(accountDataEntity: acc);
        acc.fields = fields;
        acc.setIconWidget();
      }
      _subjectAccounts.sink.add(accounts);
      // notifyListeners();
    }
  }

  void addAccount(AccountDataEntity accountDataEntity) async {
    sql_provider.addAccount(accountDataEntity: accountDataEntity).then((value) async {
        var acc = await sql_provider.getAccountById(value);
        acc.fields = accountDataEntity.fields;
        accounts.add(acc);
        _subjectAccounts.sink.add(accounts);
    });
  }

  void updateAccount(AccountDataEntity accountDataEntity) {
    int listIndex =
        accounts.indexWhere((element) => element.uuid == accountDataEntity.uuid);
    accounts[listIndex] = accountDataEntity;
    sql_provider.updateAccount(accountDataEntity);
  }

  void deleteAccount(AccountDataEntity accountDataEntity) {
    sql_provider.deleteAccount(accountDataEntity: accountDataEntity);
    accounts.remove(accountDataEntity);
    _subjectAccounts.sink.add(accounts);
  }

  void toggleEditButton({required AccountDataEntity accountDataEntity}) {
    int listIndex =
        accounts.indexWhere((element) => element.uuid == accountDataEntity.uuid);
    if (accountDataEntity.isEditButtonPressed == true) {
      accounts[listIndex].isEditButtonPressed = false;
    } else {
      accounts[listIndex].isEditButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  void toggleShowButton({required AccountDataEntity accountDataEntity}) {
    int listIndex =
        accounts.indexWhere((element) => element.uuid == accountDataEntity.uuid);

    if (accountDataEntity.isShowButtonPressed == true) {
      accounts[listIndex].isShowButtonPressed = false;
    } else {
      accounts[listIndex].isShowButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  void addField(FieldDataEntity fieldDataEntity) {
    int listIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    accounts[listIndex].fields.add(fieldDataEntity);
    _subjectAccounts.sink.add(accounts);
    sql_provider.addField(fieldDataEntity: fieldDataEntity);
  }

  void updateField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    int fieldListIndex = accounts[accListIndex]
        .fields
        .indexWhere((element) => element.uuid == fieldDataEntity.uuid);

    accounts[accListIndex].fields[fieldListIndex] = fieldDataEntity;

    sql_provider
        .updateField(fieldDataEntity);
  }

  void deleteField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.uuid == fieldDataEntity.accountId);

    accounts[accListIndex].fields.remove(fieldDataEntity);

    sql_provider
        .deleteField(fieldDataEntity: fieldDataEntity);
  }
}

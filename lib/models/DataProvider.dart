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

  DataProvider({this.sql_provider}) {
    _subjectAccounts = BehaviorSubject<List<AccountDataEntity>>();
    if (sql_provider != null) {
      fetchAndSetData();
    }
  }

  Stream<List<AccountDataEntity>> get accountsStream => _subjectAccounts.stream;

  AccountDataEntity getLocalAccountById(int id) {
    for (var acc in accounts) if (acc.id == id) return acc;

    return null;
  }

  static bool done = true;
  void initData() async {
    // INSERT INTO FieldDataEntity (accountId, name, value, position)
    // VALUES (1, "Moje pole2", "Taka se wartość2", 2),
    // (1, "Moje pole1", "Taka se wartość1", 1),
    // (2, "Moje pole11", "Taka se wartość22", 1)
    done = true;
    await sql_provider.addAccount(
        accountDataEntity: AccountDataEntity(accountName: "Test1"));
    await sql_provider.addAccount(
        accountDataEntity: AccountDataEntity(accountName: "Test2"));
    await sql_provider.addField(
        fieldDataEntity: FieldDataEntity(
            accountId: 1,
            name: "Moje pole 2",
            value: "Taka se wartość2",
            position: 2));
    await sql_provider.addField(
        fieldDataEntity: FieldDataEntity(
            accountId: 1,
            name: "Moje pole 1",
            value: "Taka se wartość1",
            position: 1));
    await sql_provider.addField(
        fieldDataEntity: FieldDataEntity(
            accountId: 2,
            name: "Moje pole 11",
            value: "Taka se wartość22",
            position: 1));
  }


  bool isAccountNameUsed({@required String name}) {
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
      if (done == false) await initData(); // TODO

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
        accounts.indexWhere((element) => element.id == accountDataEntity.id);
    accounts[listIndex] = accountDataEntity;
    sql_provider.updateAccount(accountDataEntity);
  }

  void deleteAccount(AccountDataEntity accountDataEntity) {
    sql_provider.deleteAccount(accountDataEntity: accountDataEntity);
    accounts.remove(accountDataEntity);
    _subjectAccounts.sink.add(accounts);
  }

  void toggleEditButton({AccountDataEntity accountDataEntity}) {
    int listIndex =
        accounts.indexWhere((element) => element.id == accountDataEntity.id);
    if (accountDataEntity.isEditButtonPressed == true) {
      accounts[listIndex].isEditButtonPressed = false;
    } else {
      accounts[listIndex].isEditButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  void toggleShowButton({AccountDataEntity accountDataEntity}) {
    int listIndex =
        accounts.indexWhere((element) => element.id == accountDataEntity.id);

    if (accountDataEntity.isShowButtonPressed == true) {
      accounts[listIndex].isShowButtonPressed = false;
    } else {
      accounts[listIndex].isShowButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  void addField(FieldDataEntity fieldDataEntity) {
    int listIndex = accounts
        .indexWhere((element) => element.id == fieldDataEntity.accountId);

    accounts[listIndex].fields.add(fieldDataEntity);
    _subjectAccounts.sink.add(accounts);
    sql_provider.addField(fieldDataEntity: fieldDataEntity);
  }

  void updateField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.id == fieldDataEntity.accountId);

    int fieldListIndex = accounts[accListIndex]
        .fields
        .indexWhere((element) => element.id == fieldDataEntity.id);

    accounts[accListIndex].fields[fieldListIndex] = fieldDataEntity;

    sql_provider
        .updateField(fieldDataEntity);
  }

  void deleteField(FieldDataEntity fieldDataEntity) {
    int accListIndex = accounts
        .indexWhere((element) => element.id == fieldDataEntity.accountId);

    accounts[accListIndex].fields.remove(fieldDataEntity);

    sql_provider
        .deleteField(fieldDataEntity: fieldDataEntity);
  }
}

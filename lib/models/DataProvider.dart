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

  static bool done = true;

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
    // var img = await ImagePicker().getImage(source: ImageSource.gallery);
    // accountDataEntity.iconImage = await img.readAsBytes();

    sql_provider
        .addAccount(accountDataEntity: accountDataEntity)
        .then((value) async {
      var acc = await sql_provider.getAccountById(value);
      acc.fields =
          await sql_provider.getFieldsOfAccount(accountDataEntity: acc);
      accounts.add(acc);
      _subjectAccounts.sink.add(accounts);
    });
  }

  void updateAccount(AccountDataEntity accountDataEntity) {
    sql_provider.updateAccount(accountDataEntity).then((value) => fetchAndSetData()); // TODO
  }

  void deleteAccount(AccountDataEntity accountDataEntity) {
    sql_provider.deleteAccount(accountDataEntity: accountDataEntity);
    accounts.remove(accountDataEntity);
    _subjectAccounts.sink.add(accounts);
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

  void toggleEditButton({AccountDataEntity accountDataEntity}) {
    var idInList = accounts.indexWhere((element) => element.id == accountDataEntity.id);
    if (accountDataEntity.isEditButtonPressed == true) {
      accounts[idInList].isEditButtonPressed = false;
    } else
    {
      accounts[idInList].isEditButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  void toggleShowButton({AccountDataEntity accountDataEntity}) {
    var idInList = accounts.indexWhere((element) => element.id == accountDataEntity.id);
    if (accountDataEntity.isShowButtonPressed == true) {
      accounts[idInList].isShowButtonPressed = false;
    } else
    {
      accounts[idInList].isShowButtonPressed = true;
    }
    _subjectAccounts.sink.add(accounts);
  }

  void addField(FieldDataEntity fieldDataEntity) {
    sql_provider.addField(fieldDataEntity: fieldDataEntity).then((value) => fetchAndSetData()); // TODO
  }

  void updateField(FieldDataEntity fieldDataEntity) {
    sql_provider.updateField(fieldDataEntity).then((value) => fetchAndSetData()); // TODO
  }

  void deleteField(FieldDataEntity fieldDataEntity) {
    sql_provider
        .deleteField(fieldDataEntity: fieldDataEntity)
        .then((value) => fetchAndSetData()); // TODO
  }
}

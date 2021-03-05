import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';

class DataProvider extends ChangeNotifier {
  final SQLprovider sql_provider;
  List<AccountDataEntity> accounts = [];

  DataProvider({this.sql_provider}) {
    if (sql_provider != null) {
      fetchAndSetData();
    }
  }

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
      if (done == false) await initData();
      accounts = await sql_provider.getAllAccounts();
      for (var acc in accounts) {
        List<FieldDataEntity> fields =
            await sql_provider.getFieldsOfAccount(accountDataEntity: acc);
        acc.fields = fields;
      }
      notifyListeners();
    }
  }

  void addAccount(AccountDataEntity accountDataEntity) {
    sql_provider
        .addAccount(accountDataEntity: accountDataEntity)
        .then((value) => fetchAndSetData());
  }

  bool isAccountNameUsed(
      {@required String name}) {
    bool isUsed = false;
    for (var el in accounts) {
      if (el.accountName.toLowerCase() == name.toLowerCase()) {
        isUsed = true;
        break;
      }
    }
    return isUsed;
  }

  void deleteField(FieldDataEntity fieldDataEntity) {
    sql_provider
        .deleteField(fieldDataEntity: fieldDataEntity)
        .then((value) => fetchAndSetData());
  }
}

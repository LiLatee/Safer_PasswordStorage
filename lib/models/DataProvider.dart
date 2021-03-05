import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';

class DataProvider extends ChangeNotifier {
  final SQLprovider sql_provider;
  List<AccountDataEntity> accounts = [];

  DataProvider({this.sql_provider}) {
    if (sql_provider != null) fetchAndSetData();
  }

  Future<void> fetchAndSetData() async {
    if (sql_provider.SQL_DB != null) {
      // sql_provider.addAccount(accountDataEntity: AccountDataEntity(accountName: "Test1"));
      // sql_provider.addAccount(accountDataEntity: AccountDataEntity(accountName: "Test2"));
      // sql_provider.addField(fieldDataEntity: FieldDataEntity(accountId: 1, name: "Moje pole 2", value: "Taka se wartość2", position: 2));
      // sql_provider.addField(fieldDataEntity: FieldDataEntity(accountId: 1, name: "Moje pole 1", value: "Taka se wartość1", position: 1));
      // sql_provider.addField(fieldDataEntity: FieldDataEntity(accountId: 2, name: "Moje pole 11", value: "Taka se wartość22", position: 1));
      accounts = await sql_provider.getAllAccounts();
      notifyListeners();
    }
  }

  void addAccount(AccountDataEntity accountDataEntity) {
    // accounts.add(accountDataEntity);
    sql_provider.addAccount(accountDataEntity: accountDataEntity);
    fetchAndSetData();
  }
}

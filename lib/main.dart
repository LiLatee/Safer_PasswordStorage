import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:mysimplepasswordstorage/models/sql_database.dart';
import 'package:provider/provider.dart';
import 'screens/passwords_list/passwords_list_page.dart';
import 'utils/themes.dart' as custom_themes;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final database =
  //     await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  // log(database.database.toString());
  // final accountDao = database.accountDao;
  // final account1 = AccountDataEntity(accountName: "Moje konto3");
  // // final account2 = AccountDataEntity(accountName: "Moje konto");
  //
  // // await accountDao.insertAccount(account1);
  // // await accountDao.setEditButtonState(1, 1);
  // // await accountDao.pressShowButton(1, 0);
  // // var el = await accountDao.getAccountById(1);
  // // log("${el.id} : ${el.accountName}, ${el.isShowButtonPressed}, ${el.isEditButtonPressed}");
  //
  // final result = await accountDao.getAllAccounts();
  // for (AccountDataEntity el in result)
  //   log("${el.id} : ${el.accountName}, ${el.isShowButtonPressed}, ${el.isEditButtonPressed}");
  //
  // final fieldData =
  //     FieldDataEntity(name: "Haslo", value: "haselko", accountId: account1.id);
  // final fieldDao = database.fieldDao;
  // // fieldDao.insertField(fieldData);
  //
  // // var result2 = await fieldDao.getAllFieldsOfAccount(1);
  // // for (FieldDataEntity el in result2)
  // //   log("${el.id} : ${el.name}, ${el.value}, ${el.accountId}");

  runApp(MyApp());
}

//Future<void> main() async {
//  log("elo1", name: "LOL");
//  var key = MyEncryption().generateKey(length: 5);
//  var message = "Co tam słychać?";
//  log("elo2", name: "LOL");
//  var encrypted = await MyEncryption().encrypt(password: message, secretKey: key);
//  log("elo3", name: "LOL");
//  log(encrypted.toString(), name: "LOL");
//
//}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      print(details);
      log(details.toString(), name: "OUPS in main.dart");
    };
    return MaterialApp(
      title: 'My Simple Password Storage',
      theme: custom_themes.lightTheme,
      home: PasswordsListPage(),
    );
  }
}

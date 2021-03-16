import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/app_bloc.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:mysimplepasswordstorage/models/moor_database/moor_database.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:provider/provider.dart';
import 'screens/passwords_list/passwords_list_page.dart';
import 'utils/themes.dart' as custom_themes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // final database =
  //     await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  //
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  // final AppDatabase database;

  MyApp() {
   appBloc.dispatch(AppEvent.onStart);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      // print(details);
      log(details.toString(), name: "OUPS in main.dart");
    };

    return MaterialApp(
      title: 'My Simple Password Storage',
      theme: custom_themes.lightTheme,
      home: PasswordsListPage(),
    );
  }

  @override
  void dispose() {
    appBloc.dispatch(AppEvent.onStop);
    super.dispose();
  }
}

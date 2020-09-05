import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/service_locator.dart';
import 'screens/passwords_list/passwords_list_page.dart';
import 'utils/themes.dart' as custom_themes;

void main() {
  setupLocator();
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
      log(details.toString(), name: "OUPS");
    };
    return MaterialApp(
      title: 'My Simple Password Storage',
      theme: custom_themes.lightTheme,
      home: PasswordsListPage(),
    );
  }
}

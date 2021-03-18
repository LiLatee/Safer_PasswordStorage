import 'dart:developer';
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
// import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/app_bloc.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:provider/provider.dart';
import 'screens/passwords_list/passwords_list_page.dart';
import 'utils/themes.dart' as custom_themes;
import 'package:permission_handler/permission_handler.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  /// aes_crypt
  // var crypt = AesCrypt('my cool password');
  // log(Directory.current.path);
  // log(SQLprovider.TEMP_DB.database.toString());

  // Encrypts the file srcfile.txt and saves encrypted file under original name
// with '.aes' extention added (srcfile.txt.aes). You can specify relative or
// direct path to it. To save the file into current directory specify it
// either as './srcfile.txt' or as 'srcfile.txt'.
//   crypt.encryptFileSync('srcfile.txt');

// Encrypts the file srcfile.txt and saves encrypted file under
// the name enc_file.txt.aes
//   if (await Permission.storage.request().isGranted) {
//   crypt.encryptFileSync('/data/user/0/com.example.mysimplepasswordstorage/databases/app_database.db', 'enc_file.txt.aes');
  // Either the permission was already granted before or the user just granted it.
  // }



// Decrypts the file srcfile.txt.aes and saves decrypted file under
// the name srcfile.txt
//   crypt.decryptFileSync('srcfile.txt.aes');

// Decrypts the file srcfile.txt.aes and saves decrypted file under
// the name dec_file.txt
//   crypt.decryptFileSync('srcfile.txt.aes', 'dec_file.txt');

  /// encrypt
  // final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  // final key = enc.Key.fromUtf8('my 32 length key................');
  // final iv = enc.IV.fromLength(16);
  //
  // final encrypter = enc.Encrypter(enc.AES(key));
  //
  // final encrypted = encrypter.encrypt(plainText, iv: iv);
  // final decrypted = encrypter.decrypt(encrypted, iv: iv);
  //
  // log(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  // log(encrypted.base64);



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

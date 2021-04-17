import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_simple_password_storage_clean/core/themes/app_theme.dart';
import 'package:my_simple_password_storage_clean/data/data_providers/SQLprovider.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/accounts_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLprovider.db.initDB();

  runApp(MyApp(
      accountsRepository: AccountsRepository(sqlProvider: SQLprovider())));
}

class MyApp extends StatelessWidget {
  final AccountsRepository accountsRepository;

  const MyApp({Key? key, required this.accountsRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      // print(details);
      log(details.toString(), name: "OUPS in main.dart");
    };

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AccountsCubit(accountsRepository: accountsRepository),
        ),
      ],
      child: MaterialApp(
        title: 'My Simple Password Storage',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
      ),
    );
  }
}

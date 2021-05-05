import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'core/themes/app_theme.dart';
import 'logic/cubit/all_accounts/accounts_cubit.dart';
import 'logic/cubit/all_accounts/add_account_cubit.dart';
import 'logic/cubit/all_accounts/delete_account_cubit.dart';
import 'logic/cubit/app_key_cubit.dart';
import 'logic/cubit/export_data_cubit.dart';
import 'logic/cubit/import_data_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/first_launch/key_is_needed_dialog.dart';
import 'presentation/screens/home_screen/home_screen.dart';
import 'service_locator.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      // print(details);
      log(details.toString(), name: "OUPS in main.dart");
    };

    return MultiBlocProvider(
        providers: [
          BlocProvider<AccountsCubit>(
            create: (_) => sl<AccountsCubit>(),
          ),
          BlocProvider<AddAccountCubit>(
            create: (_) => sl<AddAccountCubit>(),
          ),
          BlocProvider<DeleteAccountCubit>(
            create: (_) => sl<DeleteAccountCubit>(),
          ),
          BlocProvider<ExportDataCubit>(
            create: (_) => sl<ExportDataCubit>(),
          ),
          BlocProvider<ImportDataCubit>(
            create: (_) => sl<ImportDataCubit>(),
          ),
          BlocProvider<AppKeyCubit>(
            create: (_) => sl<AppKeyCubit>(),
          ),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            title: 'My Simple Password Storage',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: Provider.of<ThemeModel>(context).currentTheme,
            darkTheme: Provider.of<ThemeModel>(context).currentTheme,
            onGenerateRoute: sl<AppRouter>().onGenerateRoute,
            home: _getStartScreen(context: context),
          ),
        ));
  }

  Widget _getStartScreen({required BuildContext context}) {
    var appKeyCubitState = context.watch<AppKeyCubit>().state;
    if (appKeyCubitState is AppKeyPresent)
      return HomeScreen();
    else
      return FirstLaunchScreen();
  }
}

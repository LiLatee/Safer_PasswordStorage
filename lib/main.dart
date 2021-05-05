import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/all_accounts/accounts_cubit.dart';
import 'package:provider/provider.dart';

import 'core/themes/app_theme.dart';
import 'data/data_providers/SQLprovider.dart';
import 'service_locator.dart';
import 'logic/cubit/all_accounts/add_account_cubit.dart';
import 'logic/cubit/all_accounts/delete_account_cubit.dart';
import 'logic/cubit/export_data_cubit.dart';
import 'logic/cubit/import_data_cubit.dart';
import 'presentation/router/app_router.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SQLprovider.db.initDB();
  // var prefs = await SharedPreferences.getInstance();
  await di.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(
          // accountsRepository: AccountsRepositoryImlp(sqlProvider: SQLprovider()),
          // appRouter: AppRouter(sqLProvider: SQLprovider()),
          // prefs: prefs,
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final AccountsRepositoryImlp accountsRepository;
  // final AppRouter appRouter;

  // final SharedPreferences prefs;

  const MyApp({
    Key? key,
    // required this.accountsRepository,
    // required this.appRouter,
    // required this.prefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      // print(details);
      log(details.toString(), name: "OUPS in main.dart");
    };

// MultiBlocProvider(
//             providers: [
//               BlocProvider.value(
//                 value: _accountsCubit,
//               ),
//               BlocProvider<AddAccountCubit>(
//                 create: (_) => AddAccountCubit(
//                   accountsRepository: _accountsRepository,
//                   accountsCubit: _accountsCubit,
//                 ),
//               ),
//               BlocProvider<DeleteAccountCubit>(
//                 create: (_) => DeleteAccountCubit(
//                   accountsRepository: _accountsRepository,
//                   accountsCubit: _accountsCubit,
//                 ),
//               ),
//               BlocProvider<ExportDataCubit>(
//                 create: (_) => ExportDataCubit(
//                   accountsRepository: _accountsRepository,
//                 ),
//               ),
//               BlocProvider<ImportDataCubit>(
//                 create: (_) => ImportDataCubit(
//                   accountsRepository: _accountsRepository,
//                 ),
//               ),
//             ],
//             child: HomeScreen(),
//           ),

    // var prefsCubit = PreferencesCubit(prefs: prefs);
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
      ],
      child: MaterialApp(
        title: 'My Simple Password Storage',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: Provider.of<ThemeModel>(context).currentTheme,
        darkTheme: Provider.of<ThemeModel>(context).currentTheme,
        onGenerateRoute: sl<AppRouter>().onGenerateRoute,
      ),
    );
  }
}

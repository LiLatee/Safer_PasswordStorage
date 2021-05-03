import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/themes/app_theme.dart';
import 'data/data_providers/SQLprovider.dart';
import 'data/repositories/accounts_repository_impl.dart';
import 'logic/cubit/accounts_cubit.dart';
import 'logic/cubit/preferences_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLprovider.db.initDB();
  // var prefs = await SharedPreferences.getInstance();

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeModel(),
    child: MyApp(
      accountsRepository: AccountsRepositoryImlp(sqlProvider: SQLprovider()),
      appRouter: AppRouter(),
      // prefs: prefs,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AccountsRepositoryImlp accountsRepository;
  final AppRouter appRouter;

  // final SharedPreferences prefs;

  const MyApp({
    Key? key,
    required this.accountsRepository,
    required this.appRouter,
    // required this.prefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      // print(details);
      log(details.toString(), name: "OUPS in main.dart");
    };

    // var prefsCubit = PreferencesCubit(prefs: prefs);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccountsCubit(
            accountsRepository: accountsRepository,
            // preferencesCubit: prefsCubit,
          ),
        ),
        // BlocProvider.value(value: prefsCubit),
      ],
      child: MaterialApp(
        title: 'My Simple Password Storage',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: Provider.of<ThemeModel>(context).currentTheme,
        darkTheme: Provider.of<ThemeModel>(context).currentTheme,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

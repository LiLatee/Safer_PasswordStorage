import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/theme_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/auth_screen/auth_screen.dart';
import 'package:provider/provider.dart';

import 'core/themes/app_theme.dart';
import 'logic/cubit/all_accounts/accounts_cubit.dart';
import 'logic/cubit/all_accounts/add_account_cubit.dart';
import 'logic/cubit/all_accounts/delete_account_cubit.dart';
import 'logic/cubit/app_key_cubit.dart';
import 'logic/cubit/export_data_cubit.dart';
import 'logic/cubit/import_data_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/first_launch/first_launch_screen.dart';
import 'presentation/screens/home_screen/home_screen.dart';
import 'presentation/screens/splash_screen/splash_screen.dart';
import 'service_locator.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
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
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
        BlocProvider<LaunchingCubit>(
          create: (_) => sl<LaunchingCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => sl<ThemeCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (state is ThemeSystem) {
              return MaterialApp(
                title: 'My Simple Password Storage',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateRoute: sl<AppRouter>().onGenerateRoute,
                home: _getStartScreen(context: context),
              );
            } else {
              return MaterialApp(
                title: 'My Simple Password Storage',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: state is ThemeDark
                    ? AppTheme.darkTheme
                    : AppTheme.lightTheme,
                onGenerateRoute: sl<AppRouter>().onGenerateRoute,
                home: _getStartScreen(context: context),
              );
            }
          },
        ),
      ),
      // child: Builder(
      //   builder: (context) => MaterialApp(
      //     title: 'My Simple Password Storage',
      //     localizationsDelegates: AppLocalizations.localizationsDelegates,
      //     supportedLocales: AppLocalizations.supportedLocales,
      //     theme: BlocProvider.of<ThemeCubit>(context).lightTheme,
      //     darkTheme: BlocProvider.of<ThemeCubit>(context).darkTheme,
      //     onGenerateRoute: sl<AppRouter>().onGenerateRoute,
      //     home: _getStartScreen(context: context),
      //   ),
      // ),
    );
  }

  Widget? _getStartScreen({required BuildContext context}) {
    return BlocBuilder<LaunchingCubit, LaunchingState>(
      builder: (context, state) {
        if (state is LaunchingSplashScreen)
          return SplashScreen();
        // else if (state is LaunchingStartScreen)
        //   return FirstLaunchScreen();
        else if (state is LaunchingAuthScreen)
          return AuthScreen();
        else if (state is LaunchingHomeScreen)
          return HomeScreen();
        else
          throw Exception(); // TODO
      },
    );
  }
  //   var appKeyCubitState = context.watch<AppKeyCubit>().state;
  //   var authCubitState = context.watch<AuthCubit>().state;

  //   if (appKeyCubitState is AppKeyPresent) {
  //     if (authCubitState is Authenticated || authCubitState is NoSecurityMode)
  //       return HomeScreen();
  //     else
  //       return AuthScreen();
  //   } else {
  //     return FirstLaunchScreen();
  //   }
  // }
}

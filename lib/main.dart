import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';

import 'core/themes/app_theme.dart';
import 'logic/cubit/all_accounts/accounts_cubit.dart';
import 'logic/cubit/all_accounts/add_account_cubit.dart';
import 'logic/cubit/all_accounts/delete_account_cubit.dart';
import 'logic/cubit/general/app_key_cubit.dart';
import 'logic/cubit/general/auth_cubit.dart';
import 'logic/cubit/general/export_data_cubit.dart';
import 'logic/cubit/general/import_data_cubit.dart';
import 'logic/cubit/general/launching_cubit.dart';
import 'logic/cubit/general/theme_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/home_screen/home_screen.dart';
import 'presentation/screens/login_screen/login_screen.dart';
import 'presentation/screens/set_pin_code_screen/set_pin_code_screen.dart';
import 'presentation/screens/settings_screen/settings_screen.dart';
import 'presentation/screens/splash_screen/splash_screen.dart';
import 'service_locator.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
        BlocProvider<LoginCubit>(
          create: (_) => sl<LoginCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (state is ThemeSystem)
              return buildMaterialApp(
                  home: _getStartScreen(context: context), state: state);
            else
              return buildMaterialApp(
                  home: _getStartScreen(context: context), state: state);
          },
        ),
      ),
    );
  }

  MaterialApp buildMaterialApp({required Widget home, ThemeState? state}) {
    return MaterialApp(
      title: 'My Simple Password Storage',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: state is ThemeDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      onGenerateRoute: sl<AppRouter>().onGenerateRoute,
      home: home,
    );
  }

  Widget _getStartScreen({required BuildContext context}) {
    return BlocBuilder<LaunchingCubit, LaunchingState>(
      builder: (context, state) {
        log('_getStartScreen - state = $state');
        if (state is LaunchingSplashScreen)
          return SplashScreen();
        else if (state is LaunchingLoginScreen)
          return LoginScreen();
        else if (state is LaunchingSetPinCodeScreen)
          return SetPinCodeScreen();
        else if (state is LaunchingHomeScreen)
          return HomeScreen();
        else
          throw Exception(); // TODO
      },
    );
  }
}

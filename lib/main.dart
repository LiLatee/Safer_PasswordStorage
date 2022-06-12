import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/constants/AppConstants.dart';
import 'core/themes/app_theme.dart';
import 'logic/cubit/all_accounts/accounts_cubit.dart';
import 'logic/cubit/all_accounts/add_account_cubit.dart';
import 'logic/cubit/all_accounts/delete_account_cubit.dart';
import 'logic/cubit/general/app_key_cubit.dart';
import 'logic/cubit/general/auth_cubit.dart';
import 'logic/cubit/general/export_data_cubit.dart';
import 'logic/cubit/general/import_data_cubit.dart';
import 'logic/cubit/general/language_cubit.dart';
import 'logic/cubit/general/launching_cubit.dart';
import 'logic/cubit/general/login_cubit.dart';
import 'logic/cubit/general/theme_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/login_screen/login_screen.dart';
import 'presentation/screens/set_pin_code_screen/set_pin_code_screen.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
          lazy: false,
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
        BlocProvider<LanguageCubit>(
          create: (_) => sl<LanguageCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return buildMaterialApp(home: _getStartScreen(context: context), themeState: themeState, context: context);
          },
        ),
      ),
    );
  }

  MaterialApp buildMaterialApp({required Widget home, ThemeState? themeState, required BuildContext context}) {
    var languageCubitState = context.watch<LanguageCubit>().state;

    return MaterialApp(
      title: AppConstants.appName,
      locale: languageCubitState.languageCode == 'system' ? null : Locale(languageCubitState.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // theme: state is ThemeDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeState is ThemeDark ? ThemeMode.dark : ThemeMode.light,
      onGenerateRoute: sl<AppRouter>().onGenerateRoute,
      home: home,
    );
  }

  Widget _getStartScreen({required BuildContext context}) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return BlocBuilder<LaunchingCubit, LaunchingState>(
          builder: (context, state) {
            if (state is LaunchingSplashScreen)
              return SplashScreen();
            else if (state is LaunchingLoginScreen)
              return LoginScreen();
            else if (state is LaunchingSetPinCodeScreen)
              return SetPinCodeScreen();
            else
              throw Exception();
          },
        );
      },
    );
  }
}

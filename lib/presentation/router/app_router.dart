import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/auth_screen/auth_screen.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/settings_screen/settings_screen.dart';

import '../../data/data_providers/base_data_provider.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../../logic/cubit/all_accounts/accounts_cubit.dart';
import '../screens/first_launch/first_launch_screen.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouterNames {
  static const String home = '/homePage';
  static const String firstLaunch = '/firstLaunchPage';
  static const String auth = '/authPage';
  static const String settings = '/settingsPage';
}

class AppRouter {
  late AccountsRepositoryImlp _accountsRepository;
  late AccountsCubit _accountsCubit;
  late BaseDataProvider sqlProvider;

  AppRouter({required this.sqlProvider}) {
    _accountsRepository = AccountsRepositoryImlp(sqlProvider: sqlProvider);
    _accountsCubit = AccountsCubit(accountsRepository: _accountsRepository);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case AppRouterNames.firstLaunch:
        return MaterialPageRoute(
          builder: (context) => FirstLaunchScreen(),
          // fullscreenDialog: true,
        );
      case AppRouterNames.auth:
        return MaterialPageRoute(
          builder: (context) => AuthScreen(),
        );
      case AppRouterNames.settings:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        );
    }
  }
}

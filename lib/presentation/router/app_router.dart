import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/data_providers/base_data_provider.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../../logic/cubit/all_accounts/accounts_cubit.dart';
import '../screens/first_launch/first_launch_screen.dart';
import '../screens/home_screen/home_screen.dart';

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
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/firstLaunchPage':
        return MaterialPageRoute(
          builder: (context) => FirstLaunchScreen(),
          fullscreenDialog: true,
        );
    }
  }
}

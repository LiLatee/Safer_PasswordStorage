import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/data_providers/base_data_provider.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/export_data_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/import_data_cubit.dart';

import '../../data/data_providers/SQLprovider.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../../logic/cubit/all_accounts/add_account_cubit.dart';
import '../../logic/cubit/all_accounts/accounts_cubit.dart';
import '../../logic/cubit/all_accounts/delete_account_cubit.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/home_screen/widgets/key_is_needed_dialog.dart';

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
      case '/keyIsNeededDialog':
        return MaterialPageRoute(
          builder: (context) => KeyIsNeededDialog(),
          fullscreenDialog: true,
        );
    }
  }
}

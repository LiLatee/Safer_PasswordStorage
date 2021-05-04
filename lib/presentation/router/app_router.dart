import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late SQLprovider sqLProvider;

  AppRouter({required this.sqLProvider}) {
    _accountsRepository = AccountsRepositoryImlp(sqlProvider: sqLProvider);
    _accountsCubit = AccountsCubit(accountsRepository: _accountsRepository);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _accountsCubit,
                    ),
                    BlocProvider<AddAccountCubit>(
                      create: (_) => AddAccountCubit(
                        accountsRepository: _accountsRepository,
                        accountsCubit: _accountsCubit,
                      ),
                    ),
                    BlocProvider<DeleteAccountCubit>(
                      create: (_) => DeleteAccountCubit(
                        accountsRepository: _accountsRepository,
                        accountsCubit: _accountsCubit,
                      ),
                    ),
                  ],
                  child: HomeScreen(),
                ));
      case '/keyIsNeededDialog':
        return MaterialPageRoute(
          builder: (context) => KeyIsNeededDialog(),
          fullscreenDialog: true,
        );
    }
  }
}

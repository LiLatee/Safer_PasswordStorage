import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/login_screen/login_screen.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/set_pin_code_screen/set_pin_code_screen.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/settings_screen/settings_screen.dart';

import '../../data/data_providers/base_data_provider.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../../logic/cubit/all_accounts/accounts_cubit.dart';
import '../screens/first_launch/first_launch_screen.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouterNames {
  static const String home = '/homePage';
  static const String firstLaunch = '/firstLaunchPage';
  static const String setPinCode = '/setPinCodePage';
  static const String settings = '/settingsPage';
  static const String login = '/loginPage';
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
      case AppRouterNames.setPinCode:
        return MaterialPageRoute(
          builder: (context) => SetPinCodeScreen(),
        );
      case AppRouterNames.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case AppRouterNames.settings:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
          // fullscreenDialog: true,
        );
    }
  }
}

// class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
//   NoAnimationMaterialPageRoute({
//     required WidgetBuilder builder,
//     RouteSettings? settings,
//     bool maintainState = true,
//     bool fullscreenDialog = false,
//   }) : super(
//             builder: builder,
//             maintainState: maintainState,
//             settings: settings,
//             fullscreenDialog: fullscreenDialog);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return child;
//   }
// }

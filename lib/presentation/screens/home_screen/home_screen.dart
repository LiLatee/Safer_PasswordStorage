import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/router/app_router.dart';
import 'package:provider/provider.dart';

import '../../../core/themes/app_theme.dart';
import 'widgets/add_account_floating_button.dart';
import 'widgets/list_of_accounts.dart';
import 'widgets/three_dots_menu/export_dialog.dart';
import 'widgets/three_dots_menu/import_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState? _appLifecycleState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_appLifecycleState == AppLifecycleState.inactive) {
      return Scaffold(body: Center(child: Text(';)')));
    } else
      return buildHomeScreen(context);
  }

  Localizations buildHomeScreen(BuildContext context) {
    return Localizations.override(
      // TODO remove Localizations.override
      context: context,
      locale: const Locale('pl'),
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: null,
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: null,
              ),
              PopupMenuButton(
                onSelected: popupMenuOnSelected,
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: "export",
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.arrow_upward),
                      title: Text(AppLocalizations.of(context)!.exportData),
                    ),
                  ),
                  PopupMenuItem(
                    value: "import",
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.arrow_downward),
                      title: Text(AppLocalizations.of(context)!.importData),
                    ),
                  ),
                  PopupMenuItem(
                    value: "settings",
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.settings),
                      title: Text(AppLocalizations.of(context)!.settings),
                    ),
                  ),
                  // PopupMenuItem(
                  //   value: "auth",
                  //   child: ListTile(
                  //     contentPadding: EdgeInsets.zero,
                  //     leading: Icon(Icons.security),
                  //     title: Text(
                  //         AppLocalizations.of(context)!.changeSecurityMode),
                  //   ),
                  // ),
                  // const PopupMenuItem(
                  //   child: ListTile(
                  //     leading: Icon(Icons.article),
                  //     title: Text('Item 3'),
                  //   ),
                  // ),
                  // const PopupMenuDivider(),
                  // const PopupMenuItem(child: Text('Item A')),
                  // const PopupMenuItem(child: Text('Item B')),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: ListOfAccounts(),
          ),
        ),
        floatingActionButton: AddAccountFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void menuIconOnPressed() {
    UnimplementedError();
  }

  void searchIconOnPressed() {
    UnimplementedError();
  }

  void popupMenuOnSelected(value) {
    if (value == "export")
      showDialog(
        context: context,
        builder: (context) => ExportDialog(
          superContext: context,
        ),
      );
    else if (value == 'import')
      showDialog(
        context: context,
        builder: (context) => ImportDialog(),
      );
    else if (value == 'settings')
      Navigator.pushNamed(context, AppRouterNames.settings);
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     title: Text("My Simple Password Storage"),
  //   );
  // }
}

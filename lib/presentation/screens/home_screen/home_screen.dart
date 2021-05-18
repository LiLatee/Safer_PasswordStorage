import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/AppConstants.dart';
import '../../router/app_router.dart';
import 'widgets/add_account_floating_button.dart';
import 'widgets/list_of_accounts.dart';
import 'widgets/three_dots_menu/export_dialog.dart';
import 'widgets/three_dots_menu/import_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Duration _inactivityTimeout = AppConstants.durationToLogOut;
  Timer? _keepAliveTimer;

  void _keepAlive(bool visible) {
    if (_keepAliveTimer != null) _keepAliveTimer!.cancel();

    if (visible) {
      _keepAliveTimer = null;
    } else {
      _keepAliveTimer = Timer(_inactivityTimeout, () {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(AppRouterNames.login);
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _keepAlive(true);
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
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _keepAlive(false); // Conservatively set a timer on all three
        break;
    }
    setState(() {
      log('HomeScreen - state: $state');
      _appLifecycleState = state;
      // Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  late BuildContext superContext;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        superContext = context;
        if (_appLifecycleState == AppLifecycleState.inactive) {
          return Scaffold(body: Center(child: Text(';)')));
        } else
          return buildHomeScreen(superContext);
      },
    );
  }

  Widget buildHomeScreen(BuildContext context) {
    // log("KLUCZYK: ${AppSecretKeyEntity().key}");

    return Scaffold(
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
        child: ListOfAccounts(),
      ),
      floatingActionButton: AddAccountFloatingButton(superContext: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        context: superContext,
        builder: (context) => ExportDialog(
          superContext: context,
        ),
      );
    else if (value == 'import')
      showDialog(
        context: superContext,
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

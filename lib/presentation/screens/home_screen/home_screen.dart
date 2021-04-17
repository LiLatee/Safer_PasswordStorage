import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/add_account_floating_button.dart';
import 'widgets/list_of_accounts.dart';
import 'widgets/three_dots_menu/export_dialog.dart';
import 'widgets/three_dots_menu/import_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('pl'),
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: menuIconOnPressed,
              ),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.search), onPressed: searchIconOnPressed),
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
        builder: (context) => ExportDialog(),
      );
    else if (value == 'import')
      showDialog(
        context: context,
        builder: (context) => ImportDialog(),
      );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     title: Text("My Simple Password Storage"),
  //   );
  // }
}

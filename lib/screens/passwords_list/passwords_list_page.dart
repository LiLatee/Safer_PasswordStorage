import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/screens/passwords_list/components/add_account_dialog/add_account_dialog.dart';
import 'components/add_account_floating_button.dart';
import 'components/body.dart';
import './components/three_dots_menu/import_dialog.dart';
import './components/three_dots_menu/export_dialog.dart';

class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    leading: Icon(Icons.arrow_upward),
                    title: Text('Export data'),
                  ),
                ),
                PopupMenuItem(
                  value: "import",
                  child: ListTile(
                    leading: Icon(Icons.arrow_downward),
                    title: Text('Import data'),
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
          child: Body(),
        ),
      ),
      floatingActionButton: AddAccountFloatingButton(),
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
      showDialog(context: context, builder: (context) => ExportDialog(),);
    else if (value == 'import')
      showDialog(context: context, builder: (context) => ImportDialog(),);
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     title: Text("My Simple Password Storage"),
  //   );
  // }
}

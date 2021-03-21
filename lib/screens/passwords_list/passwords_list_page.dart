import 'dart:developer';
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/all_accounts_bloc.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:mysimplepasswordstorage/screens/passwords_list/components/add_account_dialog/add_account_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import '../../utils/constants.dart' as MyConstants;

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
              onPressed: () {},
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            PopupMenuButton(
              onSelected: (value) {
                if (value == "import")
                  DataProvider.importEncyptedDatabase(context: context);
                else if (value == 'export')
                  DataProvider.exportEncryptedDatabase(context: context);
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: "import",
                  child: ListTile(
                    leading: Icon(Icons.arrow_downward),
                    title: Text('Import data'),
                  ),

                ),
                PopupMenuItem(
                  value: "export",
                  child: ListTile(
                    leading: Icon(Icons.arrow_upward),
                    title: Text('Export data'),
                  ),
                ),
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.article),
                    title: Text('Item 3'),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(child: Text('Item A')),
                const PopupMenuItem(child: Text('Item B')),
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

    /// działające proste
    // return Scaffold(
    //   // appBar: buildAppBar(),
    //   // backgroundColor: Colors.white,
    //   body: Consumer<DataProvider>(
    //     builder: (context, dataProvider, child) => ListView.builder(
    //       itemCount: dataProvider.accounts.length,
    //       itemBuilder: (context, index) => Container(
    //         child: Text("Siema: ${dataProvider.accounts[index].accountName}"),
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: buildFloatingActionButton(),
    // );

    // return Scaffold(
    //   // appBar: buildAppBar(),
    //   // backgroundColor: Colors.white,
    //   body: StreamBuilder<List<AccountDataEntity>>(
    //     stream: Provider.of<AppDatabase>(context)
    //         .accountDao
    //         .watchAllAccountsAsStream(),
    //     builder: (context, AsyncSnapshot<List<AccountDataEntity>> snapshot) {
    //       if (snapshot.hasData)
    //         return ListView.builder(
    //           itemCount: snapshot.data.length,
    //           itemBuilder: (context, index) => Container(
    //             child: Text("Siema: ${snapshot.data[index].accountName}"),
    //           ),
    //         );
    //       else
    //         return CircularProgressIndicator();
    //     },
    //   ),
    //   floatingActionButton: buildFloatingActionButton(),
    // );

    // return Scaffold(
    //   // appBar: buildAppBar(),
    //   // backgroundColor: Colors.white,
    //   body: FutureBuilder<Stream<List<AccountDataEntity>>>(
    //     future: DBProvider.db.getAllAccounts(),
    //     builder:
    //         (context, AsyncSnapshot<Stream<List<AccountDataEntity>>> snapshot) {
    //       if (snapshot.hasData) {
    //         return StreamBuilder<List<AccountDataEntity>>(
    //             stream: snapshot.data,
    //             builder:
    //                 (context, AsyncSnapshot<List<AccountDataEntity>> snapshot) {
    //               if (snapshot.hasData) {
    //                 return Body(
    //                   accounts: snapshot.data,
    //                 );
    //               } else
    //                 return Container(
    //                   child: Text("NIC NIE MA"),
    //                 );
    //             });
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(), // TODO
    //         );
    //       }
    //     },
    //   ),
    //   floatingActionButton: buildFloatingActionButton(),
    // );
  }

  // FloatingActionButton buildFloatingActionButton() {
  //   return AddAccountFloatingButton(context: context, context: context);
  // }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("My Simple Password Storage"),
    );
  }
}

class AddAccountFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext superContext) {
    Size size = MediaQuery.of(superContext).size;

    return FloatingActionButton(
      onPressed: () {
        // log(SQLprovider.TEMP_DB.database.toString());
        // Provider.of<DataProvider>(context, listen: false)
        //     .addAccount(AccountDataEntity(accountName: "Dodane"));
        showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          // transitionBuilder: (context, a1, a2, widget) {
          // return Transform.scale(
          //   origin: Offset(size.width / 2,
          //       size.height / 2), // TODO jak wziąć pozycje przycisku
          //   scale: a1.value,
          //   child: Opacity(
          //     opacity: a1.value,
          //     child: AddAccountDialog(superContext: superContext),/// context required by Provider in the subtree
          //   ),
          // );
          // },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: false,
          barrierLabel: '',
          context: superContext,
          pageBuilder: (context, animation1, animation2) =>
              AddAccountDialog(superContext: superContext),
        );
        // _allAccountsBloc.addAccount();
      },
      child: Icon(Icons.add),
    );
  }
}
// AddAccountDialog(addAccountFunc: _allAccountsBloc.addAccount)

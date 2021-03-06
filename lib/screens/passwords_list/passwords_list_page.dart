import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/all_accounts_bloc.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';
import 'package:mysimplepasswordstorage/screens/passwords_list/components/add_account_dialog/add_account_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/account_data.dart';
import 'components/body.dart';
import '../../utils/constants.dart' as MyConstants;

class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  // static List<AccountData> testAccounts = [
  //   AccountData(
  //     accountName: "Facebook",
  //     email: FieldData(name: "Email", value: "me.myself.and.i@gmail.com"),
  //     password: FieldData(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
  //     icon: CircleAvatar(
  //       radius: MyConstants.defaultIconRadius,
  //       backgroundImage: AssetImage('images/facebook.png'),
  //       backgroundColor: Colors.transparent,
  //     ),
  //   ),
  //   AccountData(
  //     accountName: "Twitter",
  //     email:
  //         FieldData(name: "Email", value: "we.have_a_city_to_burn@gmail.com"),
  //     password: FieldData(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
  //     icon: CircleAvatar(
  //       radius: MyConstants.defaultIconRadius,
  //       backgroundImage: AssetImage('images/twitter.png'),
  //       backgroundColor: Colors.transparent,
  //     ),
  //   ),
  //   AccountData(
  //     accountName: "Wooggi",
  //     email: FieldData(
  //         name: "Email", value: "where_are_my_cookiesLOOOOOOLLLL?@gmail.com"),
  //     password: FieldData(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
  //   ),
  // ];

  // AllAccountsBloc _allAccountsBloc = AllAccountsBloc(accounts: testAccounts);
  // AllAccountsBloc _allAccountsBloc = AllAccountsBloc();

  @override
  Widget build(BuildContext context) {
    // testAccounts[2].addField(
    //   name: 'Notes',
    //   value: "Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie? "
    //       "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?",
    // );
    //
    // testAccounts[2].addField(
    //   name: 'Notes2',
    //   value: "Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //       "A co u Ciebie? "
    //       "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?",
    // );
    //
    // testAccounts[1].addField(name: 'Notes', value: "Haslo zwierzak");

    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      // appBar: buildAppBar(),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Body(
          accounts: dataProvider.accounts,
        ),
      ),
      floatingActionButton: AddAccountFloatingButton(),
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
        // Provider.of<DataProvider>(context, listen: false)
        //     .addAccount(AccountDataEntity(accountName: "Dodane"));
        showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              origin: Offset(size.width / 2,
                  size.height / 2), // TODO jak wziąć pozycje przycisku
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AddAccountDialog(superContext: superContext),/// context required by Provider in the subtree
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: false,
          barrierLabel: '',
          context: superContext,
          pageBuilder: (context, animation1, animation2) => null,
        );
        // _allAccountsBloc.addAccount();
      },
      child: Icon(Icons.add),
    );
  }
}
// AddAccountDialog(addAccountFunc: _allAccountsBloc.addAccount)

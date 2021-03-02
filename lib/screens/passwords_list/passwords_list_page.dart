import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/all_accounts_bloc.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data.dart';
import 'package:mysimplepasswordstorage/models/sql_database.dart';
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
  static List<AccountData> testAccounts = [
    AccountData(
      accountName: "Facebook",
      email: FieldData(name: "Email", value: "me.myself.and.i@gmail.com"),
      password: FieldData(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
      icon: CircleAvatar(
        radius: MyConstants.defaultIconRadius,
        backgroundImage: AssetImage('images/facebook.png'),
        backgroundColor: Colors.transparent,
      ),
    ),
    AccountData(
      accountName: "Twitter",
      email:
          FieldData(name: "Email", value: "we.have_a_city_to_burn@gmail.com"),
      password: FieldData(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
      icon: CircleAvatar(
        radius: MyConstants.defaultIconRadius,
        backgroundImage: AssetImage('images/twitter.png'),
        backgroundColor: Colors.transparent,
      ),
    ),
    AccountData(
      accountName: "Wooggi",
      email: FieldData(
          name: "Email", value: "where_are_my_cookiesLOOOOOOLLLL?@gmail.com"),
      password: FieldData(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
    ),
  ];

  // AllAccountsBloc _allAccountsBloc = AllAccountsBloc(accounts: testAccounts);
  AllAccountsBloc _allAccountsBloc = AllAccountsBloc();


  @override
  Widget build(BuildContext context) {
    testAccounts[2].addField(
        name: 'Notes',
        value: "Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie? "
            "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?");

    testAccounts[2].addField(
        name: 'Notes2',
        value: "Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie? "
            "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?");

    testAccounts[1].addField(name: 'Notes', value: "Haslo zwierzak");

    return Scaffold(
      // appBar: buildAppBar(),
      // backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: _allAccountsBloc.accountsStream,
        builder: (context, AsyncSnapshot<List<AccountData>> snapshot) {
          if (snapshot.hasData) {
            return Body(
              accounts: snapshot.data,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(), // TODO
            );
          }
        },
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    Size size = MediaQuery.of(context).size;

    return FloatingActionButton(
      onPressed: () {
        showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              origin: Offset(size.width / 2,
                  size.height / 2), // TODO jak wziąć pozycje przycisku
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AddAccountDialog(
                  currentAccounts: testAccounts,
                  addAccountCallback: _allAccountsBloc.addAccount,
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: false,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {},
        );
        // _allAccountsBloc.addAccount();
      },
      child: Icon(Icons.add),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("My Simple Password Storage"),
    );
  }
}
// AddAccountDialog(addAccountFunc: _allAccountsBloc.addAccount)

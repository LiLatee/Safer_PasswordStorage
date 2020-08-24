import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/all_accounts_bloc.dart';
import 'package:mysimplepasswordstorage/screens/passwords_list/components/add_account_dialog/add_account_dialog.dart';

import '../../models/account_data.dart';
import 'components/body.dart';

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
        radius: 25.0,
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
        radius: 25.0,
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

  AllAccountsBloc _allAccountsBloc = AllAccountsBloc(accounts: testAccounts);

  @override
  Widget build(BuildContext context) {
    // testAccounts[2].addField(
    //     name: 'Notes',
    //     value: "Hej. Co tam słychać? U mnie w porządku. "
    //         "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
    //         "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //         "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //         "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
    //         "A co u Ciebie? "
    //         "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?");

    // testAccounts[1].addField(name: 'Notes', value: "Haslo zwierzak");

    return Scaffold(
      // appBar: buildAppBar(),
      body: StreamBuilder(
        stream: _allAccountsBloc.accountsObservable,
        builder: (context, AsyncSnapshot<List<AccountData>> snapshot) {
          if (snapshot.hasData) {
            return Body(
              testAccounts: snapshot.data,
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
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              AddAccountDialog(addAccountFunc: _allAccountsBloc.addAccount),
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

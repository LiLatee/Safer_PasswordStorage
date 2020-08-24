import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/all_accounts_bloc.dart';

import '../../models/account_data.dart';
import 'components/body.dart';
import 'components/passwords_list.dart';

class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  static List<AccountData> testAccounts = [
    AccountData(
        accountName: "Facebook2",
        email: Field(name: "Email", value: "me.myself.and.i@gmail.com"),
        password: Field(name: "Password", value: "sdnfuimejbgdn39032fnw v")),
    AccountData(
      accountName: "Twitter",
      email: Field(name: "Email", value: "we.have_a_city_to_burn@gmail.com"),
      password: Field(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
    ),
    AccountData(
      accountName: "Facebook",
      email: Field(
          name: "Email", value: "where_are_my_cookiesLOOOOOOLLLL?@gmail.com"),
      password: Field(name: "Password", value: "sdnfuimejbgdn39032fnw v"),
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
        _allAccountsBloc.addAccount();
      },
      backgroundColor: Colors.red,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("My Simple Password Storage"),
    );
  }
}

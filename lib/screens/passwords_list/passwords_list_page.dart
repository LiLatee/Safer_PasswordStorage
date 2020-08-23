import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/account_data.dart';
import 'components/body.dart';
import 'components/passwords_list.dart';

class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  void createNewRecord() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.red,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("My Simple Password Storage"),
    );
  }
}

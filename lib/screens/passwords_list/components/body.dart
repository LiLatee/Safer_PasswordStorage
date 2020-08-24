import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/account_data.dart';
import 'account_tile/account_tile.dart';

class Body extends StatelessWidget {
  final List<AccountData> testAccounts;

  Body({@required this.testAccounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: testAccounts.length,
      itemBuilder: (var context, var index) =>
          AccountTile(accountData: testAccounts[index]),
    );
  }
}

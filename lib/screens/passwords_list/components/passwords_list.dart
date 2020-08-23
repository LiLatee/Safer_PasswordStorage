import 'package:flutter/material.dart';
import '../../../models/account_data.dart';
import 'account_tile2/account_tile.dart';

class PasswordsList extends StatelessWidget {
  const PasswordsList({
    Key key,
    @required this.testAccounts,
  }) : super(key: key);

  final List<AccountData> testAccounts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: testAccounts.length,
      itemBuilder: (var context, var index) =>
          AccountTile(accountData: testAccounts[index]),
    );
  }
}

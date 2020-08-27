import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:mysimplepasswordstorage/utils/functions.dart';

import '../../../../utils/constants.dart' as Constants;

class AccountTileHeader extends StatelessWidget {
  final AccountData accountData;
  const AccountTileHeader({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(Constants.defaultPadding),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(Constants.defaultIconRadius),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(5, 5),
              color: Colors.grey,
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            buildCircleAvatar(accountData: accountData),
            SizedBox(
              width: Constants.defaultPadding,
            ),
            Text(accountData.accountName)
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

import '../../../../constants.dart' as Constants;

class AccountTileHeader extends StatelessWidget {
  final AccountData accountData;
  const AccountTileHeader({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(Constants.defaultPadding / 2),
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
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Constants.defaultIconRadius),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
                ],
              ),
              child: accountData.icon,
            ),
            SizedBox(
              width: Constants.defaultPadding / 2,
            ),
            Text(accountData.accountName)
          ],
        ));
  }
}

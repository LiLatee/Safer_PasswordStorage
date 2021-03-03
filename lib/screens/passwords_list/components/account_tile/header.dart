import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';

import '../../../../utils/constants.dart' as MyConstants;

class AccountTileHeader extends StatelessWidget {
  final AccountDataEntity accountData;
  const AccountTileHeader({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MyConstants.defaultPadding),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
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
            // accountData.icon, // TODO
            SizedBox(
              width: MyConstants.defaultPadding,
            ),
            Text(accountData.accountName)
          ],
        ));
  }
}

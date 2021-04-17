import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/AppConstants.dart' as AppConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountTileHeader extends StatelessWidget {
  const AccountTileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountDataEntity accountDataEntity =
        Provider.of<AccountDataEntity>(context);
    return Container(
        margin: EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppConstants.defaultIconRadius),
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
            accountDataEntity.iconWidget ?? Container(), // TODO
            SizedBox(
              width: AppConstants.defaultPadding,
            ),
            Text(accountDataEntity.accountName)
          ],
        ));
  }
}

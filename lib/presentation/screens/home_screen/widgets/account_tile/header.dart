import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/core/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/AppConstants.dart' as AppConstants;
import '../../../../../data/models/account_data_entity.dart';

class AccountTileHeader extends StatelessWidget {
  const AccountTileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountDataEntity accountDataEntity =
        Provider.of<AccountDataEntity>(context);
    return Card(
        margin: EdgeInsets.all(AppConstants.defaultPadding),
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultIconRadius),
        ),
        // shadowColor: Colors.black,
        // decoration: BoxDecoration(
        //   // border: Provider.of<ThemeModel>(context).themeType == ThemeType.Dark
        //   //     ? Border.all()
        //   //     : null,
        //   borderRadius: BorderRadius.circular(AppConstants.defaultIconRadius),
        //   color: Theme.of(context).colorScheme.surface,
        //   // boxShadow: kElevationToShadow[4],
        //   // boxShadow: [
        //   //   BoxShadow(
        //   //     blurRadius: 8,
        //   //     offset: Offset(5, 5),
        //   //     color: Theme.of(context).shadowColor,
        //   //   )
        //   // ],
        // ),
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

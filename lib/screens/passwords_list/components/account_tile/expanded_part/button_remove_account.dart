import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;

import 'button_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonRemoveAccount extends StatelessWidget {
  const ButtonRemoveAccount({
    Key? key,
    required AccountDataEntity accountDataEntity,
  })   : _accountDataEntity = accountDataEntity,
        super(key: key);

  final AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    return ButtonTemplate(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => MyDialog(
            title: AppLocalizations.of(context)!.removeAccountConfirmationTitle,
            content: Container(
              child: Text(AppLocalizations.of(context)!.removeAccountConfirmationMessage),
              padding: EdgeInsets.only(top: MyConstants.defaultPadding),
            ),
            buttons: [
              MyDialogButton(
                buttonName: AppLocalizations.of(context)!.remove,
                onPressed: () {
                  DataProvider.deleteAccount(_accountDataEntity);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed "${_accountDataEntity.accountName}" account. ')));
                },
              ),
              MyDialogButton(
                buttonName: AppLocalizations.of(context)!.cancel,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      icon: Icon(Icons.delete_forever),
      label: AppLocalizations.of(context)!.remove,
    );
  }
}

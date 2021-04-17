import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/accounts_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/widgets_templates/dialog_template.dart';
import '../../../../../../core/constants/AppConstants.dart' as MyConstants;

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
              child: Text(AppLocalizations.of(context)!
                  .removeAccountConfirmationMessage),
              padding: EdgeInsets.only(top: MyConstants.defaultPadding),
            ),
            buttons: [
              MyDialogButton(
                buttonName: AppLocalizations.of(context)!.remove,
                onPressed: () {
                  // DataProvider.deleteAccount(_accountDataEntity);
                  BlocProvider.of<AccountsCubit>(context)
                      .deleteAccount(accountDataEntity: _accountDataEntity);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Removed "${_accountDataEntity.accountName}" account. ')));
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

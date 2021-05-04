import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/all_accounts/delete_account_cubit.dart';

import '../../../../../../core/constants/AppConstants.dart' as AppConstants;
import '../../../../../../data/models/account_data_entity.dart';
import '../../../../../widgets_templates/dialog_template.dart';
import 'button_template.dart';

class ButtonDeleteAccount extends StatelessWidget {
  const ButtonDeleteAccount({
    Key? key,
    required AccountDataEntity accountDataEntity,
  })   : _accountDataEntity = accountDataEntity,
        super(key: key);

  final AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext superContext) {
    return ButtonTemplate(
      onPressed: () {
        showDialog(
          context: superContext,
          builder: (context) => MyDialog(
            title: AppLocalizations.of(context)!.removeAccountConfirmationTitle,
            content: Container(
              child: Text(AppLocalizations.of(context)!
                  .removeAccountConfirmationMessage),
              padding: EdgeInsets.only(top: AppConstants.defaultPadding),
            ),
            buttons: [
              MyDialogButton(
                buttonName: AppLocalizations.of(context)!.remove,
                onPressed: () {
                  BlocProvider.of<DeleteAccountCubit>(superContext)
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
      icon: Icons.delete_forever,
      label: AppLocalizations.of(superContext)!.remove,
    );
  }
}

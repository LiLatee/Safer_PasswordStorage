import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../logic/cubit/all_accounts/add_account_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/AppConstants.dart' as AppConstants;
import '../../../../../core/constants/AppFunctions.dart' as AppFunctions;
import '../../../../../data/models/account_data_entity.dart';
import '../../../../widgets_templates/account_name_field_widget.dart';
import '../../../../widgets_templates/dialog_template.dart';
import 'choose_icon_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final BuildContext superContext;

  AddAccountDialog({required this.superContext});

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountDataEntity accountData =
      AccountDataEntity(accountName: '?????'); // TODO
  Color _currentColor = AppConstants.iconDefaultColors[0];
  final accountNameFormKey = GlobalKey<FormState>();
  bool isChosenColorIcon = true;

  void setAccountName({required String accountName}) {
    setState(() {
      accountData.accountName = accountName;

      /// Change letter on icon while changing account name.
      if (isChosenColorIcon) {
        accountData.iconWidget = AppFunctions.generateRandomColorIconAsWidget(
          name: accountData.accountName,
          color: _currentColor,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      buttons: [
        buildCancelButton(context),
        buildAddButton(context),
      ],
      content: Column(
        children: <Widget>[
          AccountNameFieldWidget(
            superContext: widget.superContext,
            onChangedCallback: setAccountName,
            accountNameFormKey: accountNameFormKey,
          ),
          Provider.value(
            value: accountData,
            child: ChooseIconWidget(
              setIsChosenColorIconCallback: ({required isChosenColorIcon}) =>
                  this.isChosenColorIcon = isChosenColorIcon,
              currentColor: _currentColor,
              context: context,
              // setCurrentColorCallback: ({color}) => currentColor = color,
            ),
          ),
          // bottomButtonsSection(context)
        ],
      ),
      title: AppLocalizations.of(context)!.addNewAccountTitle,
    );
  }

  MyDialogButton buildAddButton(BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.add,
      onPressed: () {
        if (accountNameFormKey.currentState != null) {
          if (accountNameFormKey.currentState!.validate()) {
            BlocProvider.of<AddAccountCubit>(widget.superContext)
                .addAccount(accountData: accountData);

            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .addedAccountSnackbar(accountData.accountName))));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Coś nie tak przy dodawaniu konta ;(')));
          }
        }
      },
    );
  }

  MyDialogButton buildCancelButton(BuildContext context) {
    return MyDialogButton(
        buttonName: AppLocalizations.of(context)!.cancel,
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}

import 'package:Safer/data/entities/field_data_entity.dart';
import 'package:Safer/logic/cubit/all_accounts/accounts_cubit.dart';
import 'package:Safer/logic/cubit/single_account/add_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/AppConstants.dart';
import '../../../../../core/constants/AppFunctions.dart' as AppFunctions;
import '../../../../../data/entities/account_data_entity.dart';
import '../../../../../logic/cubit/all_accounts/add_account_cubit.dart';
import 'account_name_field_widget.dart';
import '../../../../widgets_templates/dialog_template.dart';
import 'choose_icon_widget.dart';
import 'email_field_widget.dart';
import 'password_field_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final BuildContext superContext;

  AddAccountDialog({required this.superContext});

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountDataEntity accountData =
      AccountDataEntity(accountName: '?????'); // TODO
  String email = "";
  String password = "";

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

  void setEmail({required String email}) {
    setState(() {
      this.email = email;
    });
  }

  void setPassword({required String password}) {
    setState(() {
      this.password = password;
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
          EmailFieldWidget(
            superContext: widget.superContext,
            onChangedCallback: setEmail,
          ),
          PasswordFieldWidget(
            superContext: widget.superContext,
            onChangedCallback: setPassword,
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
            accountData.fields.add(FieldDataEntity(
              accountId: accountData.uuid!,
              name: AppLocalizations.of(context)!.email,
              value: email,
            ));
            accountData.fields.add(FieldDataEntity(
              accountId: accountData.uuid!,
              name: AppLocalizations.of(context)!.password,
              isHidden: true,
              value: password,
            ));

            BlocProvider.of<AddAccountCubit>(widget.superContext)
                .addAccount(accountData: accountData);

            // BlocProvider.of<AddFieldCubit>(context).addField(
            //     fieldDataEntity: FieldDataEntity(
            //   accountId: accountData.uuid!,
            //   name: AppLocalizations.of(context)!.email,
            //   value: email,
            // ));

            // BlocProvider.of<AddFieldCubit>(context).addField(
            //     fieldDataEntity: FieldDataEntity(
            //   accountId: accountData.uuid!,
            //   name: AppLocalizations.of(context)!.password,
            //   value: password,
            // ));

            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .addedAccountSnackbar(accountData.accountName))));
          }
          // else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('Coś nie tak przy dodawaniu konta ;(')));
          // }
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

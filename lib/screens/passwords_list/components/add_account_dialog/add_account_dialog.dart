import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:mysimplepasswordstorage/components/account_name_field_widget.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;
import 'choose_icon_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final BuildContext superContext;

  AddAccountDialog({this.superContext});

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountDataEntity accountDataEntity = AccountDataEntity(accountName: 'Account name');
  Color _currentColor = MyConstants.iconDefaultColors[0];
  final accountNameFormKey = GlobalKey<FormState>();
  bool isChosenColorIcon = true;

  void setAccountName({String accountName}) {
    setState(() {
      accountDataEntity.accountName = accountName;

      /// Change letter on icon while changing account name.
      if (isChosenColorIcon) {
        accountDataEntity.iconWidget = MyFunctions.generateRandomColorIconAsWidget(
          name: accountDataEntity.accountName,
          color: _currentColor,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cancelButton = MyDialogButton(
        buttonName: "Cancel",
        onPressed: () {
          Navigator.of(context).pop();
        });

    var addButton = MyDialogButton(
        buttonName: "Add",
        onPressed: () {
          if (accountNameFormKey.currentState.validate()) {
            Provider.of<DataProvider>(widget.superContext, listen: false).addAccount(accountDataEntity);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dodano konto "${accountDataEntity.accountName}"')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coś nie tak przy dodawaniu konta ;(')));
          }
        });

    return MyDialog(
      buttons: [cancelButton, addButton],
      content: Column(
        children: <Widget>[
          AccountNameFieldWidget(
            superContext: widget.superContext,
            onChangedCallback: setAccountName,
            accountNameFormKey: accountNameFormKey,
          ),
          Provider.value(
            value: accountDataEntity,
            child: ChooseIconWidget(
              setIsChosenColorIconCallback: ({isChosenColorIcon}) =>
                  this.isChosenColorIcon = isChosenColorIcon,
              currentColor: _currentColor,
              // setCurrentColorCallback: ({color}) => currentColor = color,
            ),
          ),
          // bottomButtonsSection(context)
        ],
      ),
      title: "Adding new account",
    );
  }
}

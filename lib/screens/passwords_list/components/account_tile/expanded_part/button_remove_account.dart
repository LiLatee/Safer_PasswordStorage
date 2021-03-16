import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

import 'button_template.dart';

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
            title: "Confirmation",
            content: Container(
              child: Text("Do You want to remove this account data?"),
              padding: EdgeInsets.only(top: MyConstants.defaultPadding),
            ),
            buttons: [
              MyDialogButton(
                buttonName: "Remove",
                onPressed: () {
                  DataProvider.deleteAccount(_accountDataEntity);
                  Navigator.of(context).pop();
                },
              ),
              MyDialogButton(
                buttonName: "Cancel",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      icon: Icon(Icons.delete_forever),
      label: 'Remove',
    );
  }
}

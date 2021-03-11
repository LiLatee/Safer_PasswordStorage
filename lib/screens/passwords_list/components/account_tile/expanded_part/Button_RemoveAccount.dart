import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

import 'AccountButtonTemplate.dart';

class ButtonRemoveAccount extends StatelessWidget {
  const ButtonRemoveAccount({
    Key key,
    @required DataProvider dataProvider,
    @required AccountDataEntity accountDataEntity,
  })
      : _dataProvider = dataProvider,
        _accountDataEntity = accountDataEntity,
        super(key: key);

  final DataProvider _dataProvider;
  final AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    return AccountButtonTemplate(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              MyDialog(
                title: "Confirmation",
                content: Container(
                  child: Text("Do You want to remove this account data?"),
                  padding: EdgeInsets.only(top: MyConstants.defaultPadding),
                ),
                buttons: [
                  MyDialogButton(
                    buttonName: "Remove",
                    onPressed: () {
                      _dataProvider.deleteAccount(_accountDataEntity);
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
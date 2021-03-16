import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

import 'button_template.dart';

class ButtonEditAccount extends StatelessWidget {
  const ButtonEditAccount({
    Key? key,
    required AccountDataEntity accountDataEntity,
  })   : _accountDataEntity = accountDataEntity,
        super(key: key);

  final AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    return ButtonTemplate(
      onPressed: () {
        DataProvider.toggleEditButton(accountDataEntity: _accountDataEntity);
      },
      icon: Icon(Icons.edit),
      label: 'Edit',
      pressedButtonColor: _accountDataEntity.isEditButtonPressed
          ? MyConstants.pressedButtonColor
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

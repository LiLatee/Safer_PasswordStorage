import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

import 'button_template.dart';

class ButtonShowHiddenFields extends StatelessWidget {
  const ButtonShowHiddenFields({
    Key? key,
    required AccountDataEntity accountDataEntity,
  })   : _accountDataEntity = accountDataEntity,
        super(key: key);

  final AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    return ButtonTemplate(
      onPressed: () {
        DataProvider.toggleShowButton(accountDataEntity: _accountDataEntity);
      },
      icon: Icon(Icons.remove_red_eye),
      label: 'Show',
      pressedButtonColor: _accountDataEntity.isShowButtonPressed
          ? MyConstants.pressedButtonColor
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

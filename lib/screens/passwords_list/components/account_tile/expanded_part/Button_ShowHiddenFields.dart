
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

import 'AccountButtonTemplate.dart';

class ButtonShowHiddenFields extends StatelessWidget {
  const ButtonShowHiddenFields({
    Key key,
    @required DataProvider dataProvider,
    @required AccountDataEntity accountDataEntity,
  }) : _dataProvider = dataProvider, _accountDataEntity = accountDataEntity, super(key: key);

  final DataProvider _dataProvider;
  final AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    return AccountButtonTemplate(
      onPressed: () {
        _dataProvider.toggleShowButton(accountDataEntity: _accountDataEntity);
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


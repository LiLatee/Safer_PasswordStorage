import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:provider/provider.dart';

import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;

import 'account_data_expanded_part.dart';
import 'button_add_field.dart';
import 'button_edit_account.dart';
import 'button_remove_account.dart';
import 'button_save_changes.dart';
import 'button_show_hidden_fields.dart';

class SectionButtons extends StatefulWidget {
  SectionButtons({Key? key}) : super(key: key);

  @override
  _SectionButtonsState createState() => _SectionButtonsState();
}

class _SectionButtonsState extends State<SectionButtons> {
  late AccountDataEntity _accountDataEntity;
  late IsFieldChanged _isFieldChanged;

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);
    _isFieldChanged = Provider.of<IsFieldChanged>(context);

    return Column(
      children: [
        Divider(
          color: Colors.black,
        ), // TODO?
        _isFieldChanged.isFieldChanged && _accountDataEntity.isEditButtonPressed ? ButtonSaveChanges() : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(MyConstants.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MyConstants.defaultCircularBorderRadius),
                  color: Theme.of(context).secondaryHeaderColor,
                ), // TODO
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonShowHiddenFields(
                        accountDataEntity: _accountDataEntity),
                    ButtonEditAccount(accountDataEntity: _accountDataEntity),
                    ButtonAddField(
                      accountDataEntity: _accountDataEntity,
                    ),
                    ButtonRemoveAccount(accountDataEntity: _accountDataEntity),
                    // buildAddFieldButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

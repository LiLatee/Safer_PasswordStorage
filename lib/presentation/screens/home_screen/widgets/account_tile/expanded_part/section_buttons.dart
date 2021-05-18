import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/AppConstants.dart';
import '../../../../../../data/entities/account_data_entity.dart';
import '../../../../../../logic/cubit/single_account/edit_single_account_cubit.dart';
import 'button_add_field.dart';
import 'button_delete_account.dart';
import 'button_edit_account.dart';
import 'button_save_changes.dart';
import 'button_show_hidden_fields.dart';
import 'button_undo_changes.dart';

class SectionButtons extends StatefulWidget {
  SectionButtons({Key? key}) : super(key: key);

  @override
  _SectionButtonsState createState() => _SectionButtonsState();
}

class _SectionButtonsState extends State<SectionButtons> {
  late AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);
    var editSingleAccountCubit =
        BlocProvider.of<EditSingleAccountCubit>(context);

    return Column(
      children: [
        Divider(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        editSingleAccountCubit.state is EditedSingleAccount &&
                _accountDataEntity.isEditButtonPressed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonSaveChanges(),
                  VerticalDivider(
                      color: Theme.of(context).colorScheme.onBackground),
                  ButtonUndoChanges(),
                ],
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.defaultCircularBorderRadius,
                  ),
                  color: Theme.of(context).colorScheme.primary,
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
                    ButtonDeleteAccount(accountDataEntity: _accountDataEntity),
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

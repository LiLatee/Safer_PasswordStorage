import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';
import '../../../../../../core/constants/AppConstants.dart' as MyConstants;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'account_data_expanded_part.dart';

class ButtonSaveChanges extends StatelessWidget {
  ButtonSaveChanges({
    Key? key,
  }) : super(key: key);

  late Map<String, FieldDataEntity> _changedFieldsMap;

  @override
  Widget build(BuildContext context) {
    _changedFieldsMap = Provider.of<Map<String, FieldDataEntity>>(context);

    late ButtonStyle _buttonStyle;
    if (Theme.of(context).textButtonTheme.style != null) {
      _buttonStyle = Theme.of(context).textButtonTheme.style!.copyWith(
          backgroundColor:
              TextButton.styleFrom(backgroundColor: Color(0xFFd6e0f0))
                  .backgroundColor);
    }
    return Padding(
      padding: const EdgeInsets.only(top: MyConstants.defaultPadding),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: _buttonStyle,
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: MyConstants.dismissColor,
                  ),
                  VerticalDivider(color: Colors.black),
                  Text(AppLocalizations.of(context)!.saveChangedFields),
                ],
              ),
              onPressed: () {
                updateAccount(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!
                        .saveChangedFieldsSnackbar),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateAccount(BuildContext context) {
    var accountDataEntity = BlocProvider.of<SingleAccountCubit>(context)
        .state
        .accountDataEntity
        .copyWith();

    _changedFieldsMap.forEach((key, value) {
      var index =
          accountDataEntity.fields.indexWhere((element) => element.uuid == key);
      accountDataEntity.fields[index] = value;
    });

    BlocProvider.of<SingleAccountCubit>(context)
        .updateAccount(accountDataEntity: accountDataEntity);

    _changedFieldsMap.clear();

    Provider.of<IsFieldChanged>(context, listen: false).isFieldChanged = false;
  }
}

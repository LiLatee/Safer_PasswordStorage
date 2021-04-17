import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/accounts_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';
import '../../../../../../core/constants/AppConstants.dart' as MyConstants;

import 'button_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        // DataProvider.toggleShowButton(accountDataEntity: _accountDataEntity);
        BlocProvider.of<SingleAccountCubit>(context)
            .toggleShowButton(accountDataEntity: _accountDataEntity);
      },
      icon: Icon(Icons.remove_red_eye),
      label: AppLocalizations.of(context)!.showHiddenFields,
      pressedButtonColor: _accountDataEntity.isShowButtonPressed
          ? MyConstants.pressedButtonColor
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/constants/AppConstants.dart' as AppConstants;
import '../../../../../../data/models/account_data_entity.dart';
import '../../../../../../logic/cubit/single_account_cubit.dart';
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
        // DataProvider.toggleShowButton(accountDataEntity: _accountDataEntity);
        BlocProvider.of<SingleAccountCubit>(context)
            .toggleShowButton(accountDataEntity: _accountDataEntity);
      },
      icon: Icon(Icons.remove_red_eye),
      label: AppLocalizations.of(context)!.showHiddenFields,
      pressedButtonColor: _accountDataEntity.isShowButtonPressed
          ? AppConstants.pressedButtonColor
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

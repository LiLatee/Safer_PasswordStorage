import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../logic/cubit/single_account/single_account_cubit.dart';

import '../../../../../../data/models/account_data_entity.dart';
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
        BlocProvider.of<SingleAccountCubit>(context)
            .toggleShowButton(accountDataEntity: _accountDataEntity);
      },
      icon: Icons.remove_red_eye,
      label: AppLocalizations.of(context)!.showHiddenFields,
      pressedButtonColor: _accountDataEntity.isShowButtonPressed
          ? Theme.of(context).colorScheme.secondary
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

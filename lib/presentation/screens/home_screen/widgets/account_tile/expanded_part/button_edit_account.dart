import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/edit_single_account_cubit.dart';

import '../../../../../../data/entities/account_data_entity.dart';
import '../../../../../../logic/cubit/single_account/single_account_cubit.dart';
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
    var editSingleAccountCubitState =
        context.watch<EditSingleAccountCubit>().state;

    return ButtonTemplate(
      onPressed: editSingleAccountCubitState is EditedSingleAccount
          ? null
          : () {
              BlocProvider.of<SingleAccountCubit>(context)
                  .toggleEditButton(accountDataEntity: _accountDataEntity);
            },
      icon: Icons.edit,
      label: AppLocalizations.of(context)!.editFields,
      pressedButtonColor: _accountDataEntity.isEditButtonPressed
          ? Theme.of(context).colorScheme.secondary
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

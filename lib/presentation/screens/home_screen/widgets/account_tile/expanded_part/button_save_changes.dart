import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../logic/cubit/single_account/edit_single_account_cubit.dart';
import '../../../../../../logic/cubit/single_account/single_account_cubit.dart';

import '../../../../../../core/constants/AppConstants.dart';

class ButtonSaveChanges extends StatelessWidget {
  ButtonSaveChanges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // late ButtonStyle _buttonStyle;
    // if (Theme.of(context).textButtonTheme.style != null) {
    //   _buttonStyle = Theme.of(context).textButtonTheme.style!.copyWith(
    //       backgroundColor:
    //           TextButton.styleFrom(backgroundColor: Color(0xFFd6e0f0))
    //               .backgroundColor);
    // }
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.defaultPadding),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              // style: _buttonStyle,
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    // color: AppConstants.dismissColor,
                  ),
                  // VerticalDivider(color: Colors.black),
                  Text(AppLocalizations.of(context)!.saveChangedFields),
                ],
              ),
              onPressed: () {
                BlocProvider.of<EditSingleAccountCubit>(context)
                    .updateAccount();
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
}

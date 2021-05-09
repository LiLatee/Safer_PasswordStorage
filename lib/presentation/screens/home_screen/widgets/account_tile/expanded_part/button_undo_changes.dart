import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/constants/AppConstants.dart';
import '../../../../../../logic/cubit/single_account/edit_single_account_cubit.dart';

class ButtonUndoChanges extends StatelessWidget {
  ButtonUndoChanges({
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
                    Icons.undo,
                    // color: AppConstants.dismissColor,
                  ),
                  // VerticalDivider(color: Colors.black),
                  Text(AppLocalizations.of(context)!.undoChangedFields),
                ],
              ),
              onPressed: () => BlocProvider.of<EditSingleAccountCubit>(context)
                  .undoChanges(),
            ),
          ],
        ),
      ),
    );
  }
}

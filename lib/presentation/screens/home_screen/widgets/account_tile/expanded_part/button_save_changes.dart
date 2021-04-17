import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';
import '../../../../../../core/constants/AppConstants.dart' as MyConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonSaveChanges extends StatelessWidget {
  ButtonSaveChanges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                BlocProvider.of<SingleAccountCubit>(context).updateAccount();
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

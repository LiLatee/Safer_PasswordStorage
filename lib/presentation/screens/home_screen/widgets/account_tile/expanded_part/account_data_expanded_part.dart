import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/all_accounts/add_account_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/delete_field_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/edit_single_account_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/single_account_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/AppConstants.dart' as AppConstants;
import '../../../../../../data/models/account_data_entity.dart';
import 'section_buttons.dart';
import 'section_fields.dart';

class AccountDataExpandedPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleAccountCubit, SingleAccountState>(
      builder: (context, state) {
        var editCubitState = context.watch<EditSingleAccountCubit>().state;

        var nOfFields = state.accountDataEntity.fields.length;
        var height = nOfFields * AppConstants.heightForOneField >
                AppConstants.maxHeightForFields
            ? AppConstants.maxHeightForFields
            : nOfFields * AppConstants.heightForOneField;
        AccountDataEntity currentAccount;

        currentAccount = state.accountDataEntity.copyWith();
        if (editCubitState is EditedSingleAccount ||
            editCubitState is SavingChangesSingleAccount) {
          currentAccount = (editCubitState as EditedSingleAccountState)
              .editedAccountDataEntity
              .copyWith();
        }

        return Column(
          children: [
            Container(
              height: height,
              child: Provider<AccountDataEntity>.value(
                value: currentAccount,
                child: SectionFields(),
              ),
            ),
            Provider<AccountDataEntity>.value(
              value: currentAccount,
              child: SectionButtons(),
            ),
          ],
        );
      },
    );
  }
}

// class AccountDataExpandedPart extends StatefulWidget {
//
//   AccountDataExpandedPart({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _AccountDataExpandedPartState createState() =>
//       _AccountDataExpandedPartState();
// }
//
// class _AccountDataExpandedPartState extends State<AccountDataExpandedPart> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: <Widget>[
//         // FieldsSection(),
//         // ButtonsSection(),
//       ],
//     );
//   }
// }

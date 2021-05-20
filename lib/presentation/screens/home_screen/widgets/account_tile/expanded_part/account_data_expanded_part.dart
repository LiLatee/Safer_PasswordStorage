import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/AppConstants.dart';
import '../../../../../../data/entities/account_data_entity.dart';
import '../../../../../../logic/cubit/single_account/edit_single_account_cubit.dart';
import '../../../../../../logic/cubit/single_account/single_account_cubit.dart';
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
        if ((editCubitState is EditedSingleAccountState) &&
            currentAccount.isEditButtonPressed) {
          currentAccount = editCubitState.editedAccountDataEntity.copyWith(
            isShowButtonPressed: currentAccount.isShowButtonPressed,
            isEditButtonPressed: currentAccount.isEditButtonPressed,
          );
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

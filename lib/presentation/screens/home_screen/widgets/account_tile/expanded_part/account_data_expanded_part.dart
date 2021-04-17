import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/AppConstants.dart' as MyConstants;
import 'section_buttons.dart';
import 'section_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountDataExpandedPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountDataEntity accountDataEntity =
        BlocProvider.of<SingleAccountCubit>(context).state.accountDataEntity;

    return BlocBuilder<SingleAccountCubit, SingleAccountState>(
      builder: (context, state) {
        var nOfFields = state.accountDataEntity.fields.length;
        var height = nOfFields * MyConstants.heightForOneField >
                MyConstants.maxHeightForFields
            ? MyConstants.maxHeightForFields
            : nOfFields * MyConstants.heightForOneField;
        var currentAccount;
        if (state is SingleAccountStateEditing)
          currentAccount = state.accountDataEntityChanged.copyWith();
        else if (state is SingleAccountStateReading)
          currentAccount = state.accountDataEntity.copyWith();

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

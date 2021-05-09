import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/all_accounts/accounts_cubit.dart';
import '../../../../logic/cubit/single_account/add_field_cubit.dart';
import '../../../../logic/cubit/single_account/delete_field_cubit.dart';
import '../../../../logic/cubit/single_account/edit_single_account_cubit.dart';
import '../../../../logic/cubit/single_account/single_account_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/AppConstants.dart';
import '../../../../data/models/account_data_entity.dart';
import '../../../../service_locator.dart';
import '../modified_flutter_widgets/expansion_panel.dart' as epn;
// import 'account_tile/expanded_part/account_data_expanded_part.dart';
import 'account_tile/expanded_part/account_data_expanded_part.dart';
import 'account_tile/header.dart';

class ListOfAccounts extends StatefulWidget {
  @override
  _ListOfAccountsState createState() => _ListOfAccountsState();
}

class _ListOfAccountsState extends State<ListOfAccounts> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountsCubit, AccountsState>(
      builder: (context, state) {
        if (state is AccountsLoading)
          return Center(child: CircularProgressIndicator());

        return SingleChildScrollView(
          child: epn.ExpansionPanelList.radio(
            expandedHeaderPadding:
                EdgeInsets.only(left: AppConstants.defaultPadding * 3),
            children: state.accountDataList
                .map((e) => buildExpansionPanel(accountDataEntity: e))
                .toList(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  epn.ExpansionPanelRadio buildExpansionPanel(
      {required AccountDataEntity accountDataEntity}) {
    var singleAccountCubit =
        sl<SingleAccountCubit>(param1: accountDataEntity, param2: null);

    return epn.ExpansionPanelRadio(
      canTapOnHeader: true,
      value: accountDataEntity.uuid!,
      headerBuilder: (BuildContext context, bool isExpanded) {
        // return Text("${accountDataEntity.accountName}");
        return Provider.value(
          value: accountDataEntity,
          child: AccountTileHeader(),
        );
      },
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SingleAccountCubit>.value(
            value: singleAccountCubit,
          ),
          BlocProvider<AddFieldCubit>(
            create: (_) =>
                sl<AddFieldCubit>(param1: singleAccountCubit, param2: null),
          ),
          BlocProvider<DeleteFieldCubit>(
            create: (_) =>
                sl<DeleteFieldCubit>(param1: singleAccountCubit, param2: null),
          ),
          BlocProvider<EditSingleAccountCubit>(
            create: (_) => sl<EditSingleAccountCubit>(
                param1: singleAccountCubit, param2: null),
          ),
        ],
        child: AccountDataExpandedPart(),
      ),
    );
  }
}

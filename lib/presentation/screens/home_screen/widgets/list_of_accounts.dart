import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/accounts_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';

import 'package:provider/provider.dart';

import '../modified_flutter_widgets/expansion_panel.dart' as epn;
import '../../../../core/constants/AppConstants.dart' as MyConstants;
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
                EdgeInsets.only(left: MyConstants.defaultPadding * 3),
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
      body: BlocProvider(
        create: (context) => SingleAccountCubit(
          accountsRepository:
              BlocProvider.of<AccountsCubit>(context).accountsRepository,
          accountDataEntity: accountDataEntity,
        ),
        child: AccountDataExpandedPart(),
      ),
      // body: BlocProvider(
      //   create: (context) => SingleAccountCubit(
      //     accountsRepository:
      //         BlocProvider.of<AccountsCubit>(context).accountsRepository,
      //     accountDataEntity: accountDataEntity,
      //   ),
      //   child: AccountDataExpandedPart(),
      // ),
      // body: Provider.value(
      //   value: accountDataEntity,
      //   child: AccountDataExpandedPart(),
      // ),
    );
  }
}

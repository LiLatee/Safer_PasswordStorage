import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/account_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final AccountsRepository accountsRepository;
  late StreamSubscription keyStreamSubscription;

  AccountsCubit({
    required this.accountsRepository,
  }) : super(AccountsLoading(accountDataList: <AccountDataEntity>[])) {
    fetchData();
  }

  void fetchData() {
    accountsRepository.getAllAccounts().then(
      (failureOrAccountsList) {
        failureOrAccountsList.fold(
          (failure) => null,
          (accountsList) => emit(AccountsLoaded(accountDataList: accountsList)),
        );
      },
    );
  }

  void addAccount({required AccountDataEntity accountData}) {
    final currentState = state;
    final accountsList = currentState.accountDataList;
    accountsList.add(accountData);
    emit(AccountsLoaded(accountDataList: accountsList));
  }

  void deleteAccount({required AccountDataEntity accountData}) {
    final currentState = state;
    final accountsList = currentState.accountDataList;
    accountsList.remove(accountData);
    emit(AccountsLoaded(accountDataList: accountsList));
  }

  @override
  void onChange(Change<AccountsState> change) {
    var toPrint = 'accounts_cubit:\t';
    if (change.currentState.accountDataList.length >
        change.nextState.accountDataList.length)
      change.currentState.accountDataList.forEach((element) {
        if (!change.nextState.accountDataList.contains(element))
          toPrint += 'DELETED: ${element.accountName}: ${element.uuid}\n';
      });
    else if (change.currentState.accountDataList.length <
        change.nextState.accountDataList.length)
      change.nextState.accountDataList.forEach((element) {
        if (!change.currentState.accountDataList.contains(element))
          toPrint += 'ADDED: ${element.accountName}: ${element.uuid}\n';
      });
    else
      toPrint += "No changes.";

    print(toPrint);
    super.onChange(change);
  }
}

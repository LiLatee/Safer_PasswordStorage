import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/entities/account_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final AccountsRepository accountsRepository;

  AccountsCubit({
    required this.accountsRepository,
  }) : super(AccountsLoading(accountDataList: <AccountDataEntity>[])) {
    fetchData();
  }

  void fetchData() {
    accountsRepository.getAllAccounts().then(
      (failureOrAccountsList) {
        failureOrAccountsList.fold(
          (failure) => emit(AccountsError(message: failure.toString())),
          (accountsList) => emit(AccountsLoaded(accountDataList: accountsList)),
        );
      },
    );
  }

  // Future<AccountDataEntity?> getAccountById({required String uuid}) async {
  //   var accountOrFailure = await accountsRepository.getAccountById(uuid);

  //   accountOrFailure.fold(
  //     (failure) => null,
  //     (accountDataEntity) {
  //       return accountDataEntity;
  //     },
  //   );
  // }

  void addAccount({required AccountDataEntity accountData}) {
    final currentState = state;
    final accountsList = currentState.accountDataList;
    accountsList.add(accountData);
    emit(AccountsLoaded(accountDataList: accountsList));
  }

  void deleteAccount({required AccountDataEntity accountData}) {
    final currentState = state;
    var accountsList = currentState.accountDataList;
    accountsList = accountsList
        .where((element) => element.uuid != accountData.uuid)
        .toList();

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

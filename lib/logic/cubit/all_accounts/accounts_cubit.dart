import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/account_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final AccountsRepository accountsRepository;
  // final PreferencesCubit preferencesCubit;
  late StreamSubscription keyStreamSubscription;

  AccountsCubit({
    required this.accountsRepository,
    //  required this.preferencesCubit,
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

  // StreamSubscription<PreferencesState> monitorKey() {
  //   return keyStreamSubscription = preferencesCubit.stream.listen((keyState) {
  //     if (keyState is PreferencesLoaded) {
  //       accountsRepository.key = preferencesCubit.prefs.getString('key')!;
  //       log("nowy klucz");
  //     }
  //   });
  // }

  // Future<void> exportData(
  //     {required String secretKey, required BuildContext context}) async {
  //   // AsyncSnapshot<String> result =
  //   //     await accountsRepository.exportEncryptedDatabase(secretKey, context);

  //   emit(AccountsExported(accountDataList: state.accountDataList));
  //   // return result;
  // }

  // Future<void> importData(
  //     {required String secretKey,
  //     required BuildContext context,
  //     required String filepath}) async {
  //   // AsyncSnapshot<String> result =
  //   //     await accountsRepository.importEncryptedDatabase(
  //   //         context: context, secretKey: secretKey, filepath: filepath);

  //   emit(AccountsImported(
  //       accountDataList: await accountsRepository.getAllAccounts()));
  //   // return result;
  // }

  // @override
  // Future<void> close() {
  //   keyStreamSubscription.cancel();
  //   return super.close();
  // }

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

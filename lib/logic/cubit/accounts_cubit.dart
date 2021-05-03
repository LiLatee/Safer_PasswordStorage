import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/preferences_cubit.dart';

import '../../data/models/account_data_entity.dart';
import '../../data/repositories/accounts_repository_impl.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final AccountsRepositoryImlp accountsRepository;
  // final PreferencesCubit preferencesCubit;
  late StreamSubscription keyStreamSubscription;

  AccountsCubit({
    required this.accountsRepository,
    //  required this.preferencesCubit,
  }) : super(AccountsLoading(accountDataList: <AccountDataEntity>[])) {
    accountsRepository.getAllAccounts().then(
      (failureOrAccountsList) {
        failureOrAccountsList.fold(
          (failure) {
            return null; // TODO
          },
          (accountsList) {
            emit(
              AccountsLoaded(accountDataList: accountsList),
            );
          },
        );
      },
    );
  }

  // StreamSubscription<PreferencesState> monitorKey() {
  //   return keyStreamSubscription = preferencesCubit.stream.listen((keyState) {
  //     if (keyState is PreferencesLoaded) {
  //       accountsRepository.key = preferencesCubit.prefs.getString('key')!;
  //       log("nowy klucz");
  //     }
  //   });
  // }

  Future<void> addAccount({required AccountDataEntity accountData}) async {
    var failureOrSuccess =
        await accountsRepository.addAccount(accountData: accountData);

    failureOrSuccess.fold(
      (failure) => null,
      (success) async {
        var failureOrAllAccounts = await accountsRepository.getAllAccounts();

        failureOrAllAccounts.fold(
          (failure) => null,
          (allAccounts) => emit(
            AccountsLoaded(accountDataList: allAccounts),
          ),
        );
      },
    );
  }

  Future<void> deleteAccount(
      {required AccountDataEntity accountDataEntity}) async {
    var failureOrSuccess =
        await accountsRepository.deleteAccount(accountData: accountDataEntity);

    failureOrSuccess.fold(
      (failure) => null,
      (success) async {
        var failureOrAllAccounts = await accountsRepository.getAllAccounts();
        failureOrAllAccounts.fold(
          (failure) => null,
          (allAccounts) => emit(AccountsLoaded(accountDataList: allAccounts)),
        );
      },
    );
  }

  Future<void> exportData(
      {required String secretKey, required BuildContext context}) async {
    // AsyncSnapshot<String> result =
    //     await accountsRepository.exportEncryptedDatabase(secretKey, context);

    emit(AccountsExported(accountDataList: state.accountDataList));
    // return result;
  }

  Future<void> importData(
      {required String secretKey,
      required BuildContext context,
      required String filepath}) async {
    // AsyncSnapshot<String> result =
    //     await accountsRepository.importEncryptedDatabase(
    //         context: context, secretKey: secretKey, filepath: filepath);

    emit(AccountsImported(
        accountDataList: await accountsRepository.getAllAccounts()));
    // return result;
  }

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

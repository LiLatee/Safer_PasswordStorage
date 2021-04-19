import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/account_data_entity.dart';
import '../../data/repositories/accounts_repository.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final AccountsRepository accountsRepository;

  AccountsCubit({required this.accountsRepository})
      : super(AccountsLoading(accountDataList: <AccountDataEntity>[])) {
    accountsRepository
        .getAllAccounts()
        .then((value) => emit(AccountsLoaded(accountDataList: value)));
  }

  Future<void> addAccount({required AccountDataEntity accountData}) async {
    // state.accountDataList.add(accountData);
    await accountsRepository.addAccount(accountData: accountData);
    emit(AccountsLoaded(
        accountDataList: await accountsRepository.getAllAccounts()));
  }

  Future<void> deleteAccount(
      {required AccountDataEntity accountDataEntity}) async {
    await accountsRepository.deleteAccount(accountData: accountDataEntity);
    var accounts = await accountsRepository.getAllAccounts();
    emit(AccountsLoaded(accountDataList: accounts));
  }

  Future<AsyncSnapshot<String>> exportData(
      {required String secretKey, required BuildContext context}) async {
    AsyncSnapshot<String> result =
        await accountsRepository.exportEncryptedDatabase(secretKey, context);

    emit(AccountsExported(accountDataList: state.accountDataList));
    return result;
  }

  Future<AsyncSnapshot<String>> importData(
      {required String secretKey,
      required BuildContext context,
      required String filepath}) async {
    AsyncSnapshot<String> result =
        await accountsRepository.importEncryptedDatabase(
            context: context, secretKey: secretKey, filepath: filepath);

    var importedAccountsList = await accountsRepository.getAllAccounts();
    emit(AccountsImported(accountDataList: importedAccountsList));
    return result;
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

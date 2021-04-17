import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';

part 'single_account_state.dart';

class SingleAccountCubit extends Cubit<SingleAccountState> {
  // final AccountDataEntity accountDataEntity;
  final AccountsRepository accountsRepository;

  SingleAccountCubit({
    required accountDataEntity,
    required this.accountsRepository,
  }) : super(SingleAccountState(accountDataEntity: accountDataEntity));

  Future<void> addField({required FieldDataEntity fieldDataEntity}) async {
    log("addField");
    await accountsRepository.addField(fieldData: fieldDataEntity);
    // AccountDataEntity modifiedAccountData = (await accountsRepository.getAccountById(fieldDataEntity.accountId) as AccountDataEntity);
    var modifiedAccountData = (await accountsRepository
        .getAccountById(fieldDataEntity.accountId) as AccountDataEntity);

    emit(SingleAccountState(accountDataEntity: modifiedAccountData));
  }

  Future<void> deleteField({required FieldDataEntity fieldDataEntity}) async {
    log("deleteField");
    await accountsRepository.deleteField(fieldData: fieldDataEntity);

    AccountDataEntity modifiedAccountData =
        (await accountsRepository.getAccountById(fieldDataEntity.accountId))!;

    modifiedAccountData.isEditButtonPressed =
        state.accountDataEntity.isEditButtonPressed;

    modifiedAccountData.isShowButtonPressed =
        state.accountDataEntity.isShowButtonPressed;

    emit(SingleAccountState(accountDataEntity: modifiedAccountData));
  }

  Future<void> toggleEditButton(
      {required AccountDataEntity accountDataEntity}) async {
    log("toggleEditButton");
    AccountDataEntity newAccountData;
    if (accountDataEntity.isEditButtonPressed == true) {
      newAccountData = accountDataEntity.copyWith(isEditButtonPressed: false);
      // accounts[listIndex].isEditButtonPressed = false;
    } else {
      newAccountData = accountDataEntity.copyWith(isEditButtonPressed: true);
    }

    emit(SingleAccountState(accountDataEntity: newAccountData));
  }

  Future<void> toggleShowButton(
      {required AccountDataEntity accountDataEntity}) async {
    log("toggleShowButton");
    AccountDataEntity newAccountData;
    if (accountDataEntity.isShowButtonPressed == true) {
      newAccountData = accountDataEntity.copyWith(isShowButtonPressed: false);
      // accounts[listIndex].isShowButtonPressed = false;
    } else {
      newAccountData = accountDataEntity.copyWith(isShowButtonPressed: true);
    }

    emit(SingleAccountState(accountDataEntity: newAccountData));
  }

  Future<void> updateAccount(
      {required AccountDataEntity accountDataEntity}) async {
    log("updateAccount");
    await accountsRepository.updateAccount(accountDataEntity);
    var modifiedAccountData =
        await accountsRepository.getAccountById(accountDataEntity.uuid!);

    modifiedAccountData!.isEditButtonPressed =
        state.accountDataEntity.isEditButtonPressed;

    modifiedAccountData.isShowButtonPressed =
        state.accountDataEntity.isShowButtonPressed;

    emit(SingleAccountState(accountDataEntity: modifiedAccountData));
  }

  @override
  void onChange(Change<SingleAccountState> change) {
    var toPrint = 'single_account_cubit:\tChange(\n';
    if (change.currentState.accountDataEntity.uuid !=
        change.nextState.accountDataEntity.uuid)
      toPrint += "\tuuid: " +
          change.currentState.accountDataEntity.uuid.toString() +
          " --> " +
          change.nextState.accountDataEntity.uuid.toString() +
          '\n';

    if (change.currentState.accountDataEntity.accountName !=
        change.nextState.accountDataEntity.accountName)
      toPrint += "\taccountName: " +
          change.currentState.accountDataEntity.accountName.toString() +
          " --> " +
          change.nextState.accountDataEntity.accountName.toString() +
          '\n';

    if (change.currentState.accountDataEntity.iconColorHex !=
        change.nextState.accountDataEntity.iconColorHex)
      toPrint += "\ticonColorHex: " +
          change.currentState.accountDataEntity.iconColorHex.toString() +
          " --> " +
          change.nextState.accountDataEntity.iconColorHex.toString() +
          '\n';

    if (change.currentState.accountDataEntity.isShowButtonPressed !=
        change.nextState.accountDataEntity.isShowButtonPressed)
      toPrint += "\tisShowButtonPressed: " +
          change.currentState.accountDataEntity.isShowButtonPressed.toString() +
          " --> " +
          change.nextState.accountDataEntity.isShowButtonPressed.toString() +
          '\n';

    if (change.currentState.accountDataEntity.isEditButtonPressed !=
        change.nextState.accountDataEntity.isEditButtonPressed)
      toPrint += "\tisEditButtonPressed: " +
          change.currentState.accountDataEntity.isEditButtonPressed.toString() +
          " --> " +
          change.nextState.accountDataEntity.isEditButtonPressed.toString() +
          '\n';

    if (change.currentState.accountDataEntity.fields !=
        change.nextState.accountDataEntity.fields)
      toPrint += "\tfields: " +
          change.currentState.accountDataEntity.fields.toString() +
          " --> " +
          change.nextState.accountDataEntity.fields.toString() +
          '\n)';

    // if (change.currentState.accountDataEntity.iconImage !=
    //     change.nextState.accountDataEntity.iconImage)
    //   toPrint += "iconImage: " +
    //       change.currentState.accountDataEntity.iconImage.toString() +
    //       " --> " +
    //       change.nextState.accountDataEntity.iconImage.toString() +
    //       '\n)';

    print(toPrint);
    super.onChange(change);
  }
}

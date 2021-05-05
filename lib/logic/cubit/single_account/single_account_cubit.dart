import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';

part 'single_account_state.dart';

class SingleAccountCubit extends Cubit<SingleAccountState> {
  final AccountsRepository accountsRepository;

  SingleAccountCubit({
    required accountDataEntity,
    required this.accountsRepository,
  }) : super(SingleAccountReadingState(accountDataEntity: accountDataEntity));

  Future<void> toggleEditButton(
      {required AccountDataEntity accountDataEntity}) async {
    log("SingleAccountCubit - toggleEditButton");
    AccountDataEntity newAccountData;

    if (accountDataEntity.isEditButtonPressed == true)
      newAccountData = accountDataEntity.copyWith(isEditButtonPressed: false);
    else
      newAccountData = accountDataEntity.copyWith(isEditButtonPressed: true);

    emit(SingleAccountReadingState(accountDataEntity: newAccountData));
  }

  Future<void> toggleShowButton(
      {required AccountDataEntity accountDataEntity}) async {
    log("SingleAccountCubit - toggleShowButton");
    AccountDataEntity newAccountData;
    if (accountDataEntity.isShowButtonPressed == true)
      newAccountData = accountDataEntity.copyWith(isShowButtonPressed: false);
    else
      newAccountData = accountDataEntity.copyWith(isShowButtonPressed: true);

    emit(SingleAccountReadingState(accountDataEntity: newAccountData));
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

  void addField({required FieldDataEntity fieldData}) {
    final currentState = state;
    if (currentState is SingleAccountReadingState) {
      final accountData = currentState.accountDataEntity.copyWith();
      accountData.fields.add(fieldData);
      emit(SingleAccountReadingState(accountDataEntity: accountData));
    }
  }

  void deleteField({required FieldDataEntity fieldData}) {
    final currentState = state;
    if (currentState is SingleAccountReadingState) {
      final accountData = currentState.accountDataEntity.copyWith();
      accountData.fields.remove(fieldData);

      accountData.isEditButtonPressed =
          state.accountDataEntity.isEditButtonPressed;

      accountData.isShowButtonPressed =
          state.accountDataEntity.isShowButtonPressed;

      emit(SingleAccountReadingState(accountDataEntity: accountData));
    }
  }

  void updateAccount({required AccountDataEntity newAccountData}) {
    final currentState = state;
    if (currentState is SingleAccountReadingState) {
      newAccountData.isEditButtonPressed =
          currentState.accountDataEntity.isEditButtonPressed;

      newAccountData.isShowButtonPressed =
          currentState.accountDataEntity.isShowButtonPressed;

      emit(SingleAccountReadingState(accountDataEntity: newAccountData));
    }
  }
}

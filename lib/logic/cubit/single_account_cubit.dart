import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/account_data_entity.dart';
import '../../data/models/field_data_entity.dart';
import '../../data/repositories/accounts_repository_impl.dart';

part 'single_account_state.dart';

class SingleAccountCubit extends Cubit<SingleAccountState> {
  final AccountsRepositoryImlp accountsRepository;

  SingleAccountCubit({
    required accountDataEntity,
    required this.accountsRepository,
  }) : super(SingleAccountStateReading(accountDataEntity: accountDataEntity));

  Future<void> addField({required FieldDataEntity fieldDataEntity}) async {
    log("addField");
    await accountsRepository.addField(fieldData: fieldDataEntity);

    var failureOrModifiedAccountData =
        (await accountsRepository.getAccountById(fieldDataEntity.accountId));

    failureOrModifiedAccountData.fold(
      (failure) {
        return null; // TODO
      },
      (modifiedAccountData) {
        emit(
            SingleAccountStateReading(accountDataEntity: modifiedAccountData!));
      },
    );
  }

  Future<void> deleteField({required FieldDataEntity fieldDataEntity}) async {
    log("deleteField");
    await accountsRepository.deleteField(fieldData: fieldDataEntity);

    var failureOrModifiedAccountData =
        (await accountsRepository.getAccountById(fieldDataEntity.accountId));

    failureOrModifiedAccountData.fold(
      (failure) {
        return null; // TODO
      },
      (modifiedAccountData) {
        modifiedAccountData!.isEditButtonPressed =
            state.accountDataEntity.isEditButtonPressed;

        modifiedAccountData.isShowButtonPressed =
            state.accountDataEntity.isShowButtonPressed;

        emit(SingleAccountStateReading(accountDataEntity: modifiedAccountData));
      },
    );
  }

  Future<void> toggleEditButton(
      {required AccountDataEntity accountDataEntity}) async {
    log("toggleEditButton");
    AccountDataEntity newAccountData;

    if (accountDataEntity.isEditButtonPressed == true)
      newAccountData = accountDataEntity.copyWith(isEditButtonPressed: false);
    else
      newAccountData = accountDataEntity.copyWith(isEditButtonPressed: true);

    emit(SingleAccountStateReading(accountDataEntity: newAccountData));
  }

  Future<void> toggleShowButton(
      {required AccountDataEntity accountDataEntity}) async {
    log("toggleShowButton");
    AccountDataEntity newAccountData;
    if (accountDataEntity.isShowButtonPressed == true)
      newAccountData = accountDataEntity.copyWith(isShowButtonPressed: false);
    else
      newAccountData = accountDataEntity.copyWith(isShowButtonPressed: true);

    emit(SingleAccountStateReading(accountDataEntity: newAccountData));
  }

  void changeField({required FieldDataEntity fieldDataEntity}) {
    log("changeField");
    // log(state.accountDataEntity.toString());
    // if (state is SingleAccountStateEditing)
    //   log((state as SingleAccountStateEditing)
    //       .accountDataEntityChanged
    //       .toString());

    var modifiedAccountData;

    /// When you change first character.
    if (state is SingleAccountStateReading)
      modifiedAccountData = state.accountDataEntity.copyWith();

    /// When you change next characters.
    else if (state is SingleAccountStateEditing)
      modifiedAccountData = (state as SingleAccountStateEditing)
          .accountDataEntityChanged
          .copyWith();

    var index = state.accountDataEntity.fields
        .indexWhere((element) => element.uuid == fieldDataEntity.uuid);

    modifiedAccountData.fields[index] = fieldDataEntity.copyWith();

    emit(SingleAccountStateEditing(
        accountDataEntity: state.accountDataEntity,
        accountDataEntityChanged: modifiedAccountData));
  }

  Future<void> updateAccount() async {
    log("updateAccount");
    await accountsRepository.updateAccount(
        (state as SingleAccountStateEditing).accountDataEntityChanged);

    var failureOrModifiedAccountData =
        await accountsRepository.getAccountById(state.accountDataEntity.uuid);

    failureOrModifiedAccountData.fold(
      (failure) {
        return null; // TODO
      },
      (modifiedAccountData) {
        modifiedAccountData!.isEditButtonPressed =
            state.accountDataEntity.isEditButtonPressed;

        modifiedAccountData.isShowButtonPressed =
            state.accountDataEntity.isShowButtonPressed;

        emit(SingleAccountStateReading(accountDataEntity: modifiedAccountData));
      },
    );
  }

  Future<void> undoChanges() async {
    log("undoChanges");
    emit(SingleAccountStateReading(accountDataEntity: state.accountDataEntity));
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

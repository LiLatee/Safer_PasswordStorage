import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/account_data_entity.dart';
import '../../../data/models/field_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';
import 'single_account_cubit.dart';

part 'edit_single_account_state.dart';

class EditSingleAccountCubit extends Cubit<EditSingleAccountState> {
  final AccountsRepository accountsRepository;
  final SingleAccountCubit singleAccountCubit;

  EditSingleAccountCubit({
    required this.accountsRepository,
    required this.singleAccountCubit,
  }) : super(EditSingleAccountInitial());

  void changeField({required FieldDataEntity fieldDataEntity}) {
    log("EditSingleAccountCubit - changeField");
    var modifiedAccountData;

    /// When changed first character.
    if (state is EditSingleAccountInitial) {
      modifiedAccountData =
          singleAccountCubit.state.accountDataEntity.copyWith();
    }

    /// When changed next characters.
    else if (state is EditedSingleAccount) {
      modifiedAccountData =
          (state as EditedSingleAccount).editedAccountDataEntity.copyWith();
    }

    var index = modifiedAccountData.fields
        .indexWhere((element) => element.uuid == fieldDataEntity.uuid);

    modifiedAccountData.fields[index] = fieldDataEntity.copyWith();

    emit(EditedSingleAccount(editedAccountDataEntity: modifiedAccountData));
  }

  Future<void> updateAccount() async {
    log("EditSingleAccountCubit -updateAccount");

    var accToUpdate =
        (state as EditedSingleAccount).editedAccountDataEntity.copyWith();

    emit(SavingChangesSingleAccount(editedAccountDataEntity: accToUpdate));

    await accountsRepository.updateAccount(accToUpdate);

    singleAccountCubit.updateAccount(newAccountData: accToUpdate);
    emit(EditSingleAccountInitial());
  }

  Future<void> undoChanges() async {
    log("EditSingleAccountCubit - undoChanges");
    emit(EditSingleAccountInitial());
  }
}

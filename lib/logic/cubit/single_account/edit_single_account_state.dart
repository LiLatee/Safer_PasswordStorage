part of 'edit_single_account_cubit.dart';

abstract class EditSingleAccountState extends Equatable {
  const EditSingleAccountState();

  @override
  List<Object> get props => [];
}

class EditSingleAccountInitial extends EditSingleAccountState {}

abstract class EditedSingleAccountState extends EditSingleAccountState {
  final AccountDataEntity editedAccountDataEntity;

  EditedSingleAccountState({required this.editedAccountDataEntity});

  @override
  List<Object> get props => [editedAccountDataEntity];
}

class EditedSingleAccount extends EditedSingleAccountState {
  EditedSingleAccount({editedAccountDataEntity})
      : super(editedAccountDataEntity: editedAccountDataEntity);
}

class UndidChangesSingleAccount extends EditSingleAccountState {}

class SavingChangesSingleAccount extends EditedSingleAccountState {
  SavingChangesSingleAccount({editedAccountDataEntity})
      : super(editedAccountDataEntity: editedAccountDataEntity);
}

class SavedChangesSingleAccount extends EditSingleAccountState {}

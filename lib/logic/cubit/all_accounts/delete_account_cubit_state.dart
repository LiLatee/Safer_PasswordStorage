part of 'delete_account_cubit.dart';

abstract class DeleteAccountCubitState extends Equatable {
  const DeleteAccountCubitState();

  @override
  List<Object> get props => [];
}

class DeleteAccountCubitInitial extends DeleteAccountCubitState {}

class DeletingAccount extends DeleteAccountCubitState {}

class DeletedAccount extends DeleteAccountCubitState {}
